require 'pry'
require 'rspec'

require_relative '../server.rb'

set :environment, :test
set :database, :test

FactoryGirl.definition_file_paths = ['./spec/factories']
FactoryGirl.find_definitions

Capybara.app = Sinatra::Application
