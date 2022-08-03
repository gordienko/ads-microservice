require 'bunny'
require 'thread'
require 'json'
require 'securerandom'
require_relative 'api'

module GeocoderSync
  class Client
    attr_accessor :call_id, :response, :lock, :condition, :connection,
                  :channel, :server_queue_name, :reply_queue, :exchange

    include Api

    def initialize
      @connection = Bunny.new(automatically_recover: false)
      @connection.start

      @channel = connection.create_channel
      @exchange = channel.default_exchange
      @server_queue_name = 'ads_sync'

      setup_reply_queue
    end

    def stop
      channel.close
      connection.close
    end

    private

    def setup_reply_queue
      @lock = Mutex.new
      @condition = ConditionVariable.new
      that = self
      @reply_queue = channel.queue('', exclusive: true)

      reply_queue.subscribe do |_delivery_info, properties, payload|
        if properties[:correlation_id] == that.call_id
          that.response = payload

          # sends the signal to continue the execution of #call
          that.lock.synchronize { that.condition.signal }
        end
      end
    end
  end
end
