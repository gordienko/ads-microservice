# frozen_string_literal: true

require_relative 'config/environmant'

# run Application

map '/ads' do
  run AdRoutes
end
