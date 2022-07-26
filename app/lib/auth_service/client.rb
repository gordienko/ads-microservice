# frozen_string_literal: true

require 'dry/initializer'
require_relative 'api'

module AuthService
  # AuthService Client
  class Client
    extend Dry::Initializer[undefined: false]
    include Api

    option :url, default: proc { Settings.service.auth.url }
    option :connection, default: proc { build_connection }

    private

    def build_connection
      Faraday.new(@url) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.ssl[:verify] = false
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
