# frozen_string_literal: true

# Rabbit Mq module
#
module RabbitMq
  module_function

  @mutex = Mutex.new

  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new.start
    end
  end

  def channel
    Thread.current[:rabbitmq_channel] ||= connection.create_channel
  end

  def consumer_channel
    Thread.current[:rabbitmq_consumer_channel] ||= connection.create_channel(
      nil,
      Settings.rabbitmq.consumer_pool
    )
  end
end
