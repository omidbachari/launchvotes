require_relative '../server.rb'

require 'database_cleaner'
require 'factory_girl'
require 'pry'
require 'rspec'
require 'shoulda/matchers'

set :environment, :test
set :database, :test

FactoryGirl.definition_file_paths = ['./spec/factories']
FactoryGirl.find_definitions

RSpec.configure do |config|
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
