# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'puma', '~> 4.3.0'
gem 'rake', '~> 13.0.1'

gem 'faraday', '~> 1.10'
gem 'faraday_middleware', '~> 1.2'
gem 'sinatra', '~> 2.0', require: 'sinatra/base'
gem 'sinatra-contrib', '~> 2.0'

gem 'config', '~> 2.2'
gem 'i18n', '~> 1.8.2'

gem 'pg', '~> 1.2.3'
gem 'sequel', '~> 5.32.0'

gem 'dry-initializer', '~> 3.0.3'
gem 'dry-validation', '~> 1.5.0'

gem 'activesupport', '~> 6.0.0', require: false
gem 'fast_jsonapi', '~> 1.5'

group 'test' do
  gem 'database_cleaner-sequel', '~> 1.8.0'
  gem 'factory_bot', '~> 5.2.0'
  gem 'rack-test', '~> 1.1.0'
  gem 'rspec', '~> 3.9.0'
end

group 'development' do
  gem 'pry', '~> 0.13.1'
  gem 'rubocop', '~> 1.22'
  gem 'rubocop-rake', '~> 0.6.0'
  gem 'rubocop-rspec', '~> 2.11'
  gem 'rubocop-sequel', '~> 0.3.4'
end
