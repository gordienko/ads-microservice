# frozen_string_literal: true

require 'pry'

module GeokoderService
  # GeokoderService API
  module Api
    def code(city)
      response = connection.post('v1') do |request|
        request.params['city'] = city
      end

      response.body if response.success?
    end
  end
end
