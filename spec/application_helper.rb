# frozen_string_literal: true

require 'rack/test'
require 'database_cleaner'
require 'factory_bot'
require 'spec_helper'

ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environmant'

abort('You run tests in production mode. Please don\'t do this!') if Application.environment == :production
Dir[Application.root.concat('/spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
  config.include ClientHelpers, type: :client
end
