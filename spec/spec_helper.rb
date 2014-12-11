require_relative '../server.rb'

require 'capybara/rspec'
require 'database_cleaner'
require 'factory_girl'
require 'pry'
require 'rspec'
require 'shoulda/matchers'
require 'support/authentication_helper'
require 'valid_attribute'

set :environment, :test
set :database, :test

FactoryGirl.definition_file_paths = ['./spec/factories']
FactoryGirl.find_definitions

OmniAuth.config.test_mode = true
include AuthenticationHelper

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

Capybara.app = Sinatra::Application
