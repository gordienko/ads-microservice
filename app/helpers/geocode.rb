# frozen_string_literal: true

require 'pry'

# Geocode Helpers
#
module Geocode
  class Notfound < StandardError; end

  def coordinates
    coordinates = geocoder_client.code(city)
    raise Notfound if coordinates.blank?
    coordinates
  end

  private

  def city
    @city ||= params.dig('ad', 'city')
  end

  def geocoder_client
    @geocoder_client ||= GeokoderService::Client.new
  end
end
