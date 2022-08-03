# frozen_string_literal: true

module GeocoderSync
  # Geocoder Api Service
  module Api
    def geocode_now(ad)
      @call_id = SecureRandom.uuid

      payload = { city: ad.city }.to_json
      exchange.publish(payload,
                       routing_key: server_queue_name,
                       correlation_id: call_id,
                       reply_to: reply_queue.name)

      # wait for the signal to continue the execution
      lock.synchronize { condition.wait(lock) }

      response
    end
  end
end
