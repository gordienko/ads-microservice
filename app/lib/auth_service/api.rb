# frozen_string_literal: true

require 'pry'

module AuthService
  # AuthService API
  module Api
    def auth(token)
      response = connection.post('auth/v1') do |request|
        request.params['token'] = token
      end

      response.body.dig('data', 'id') if response.success?
    end
  end
end
