# frozen_string_literal: true

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
    option :coordinates

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      if coordinates.present?
        @ad.lat = coordinates['lat']
        @ad.lon = coordinates['lon']
      end

      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end
  end
end
