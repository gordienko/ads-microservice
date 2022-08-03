# frozen_string_literal: true

require 'pry'

module Ads
  # Create Ads Service
  #
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id
    option :geocoder_service, default: proc { GeocoderSync::Client.new }

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      if @ad.valid?
        @ad.save

        coordinates = JSON(@geocoder_service.geocode_now(@ad)).transform_keys(&:to_sym)
        if coordinates.present?
          @ad.update_fields(coordinates, %i[lat lon])
        end

      else
        fail!(@ad.errors)
      end
    end
  end
end
