require './server'
require 'sinatra/activerecord/rake'

if Sinatra::Base.development? || Sinatra::Base.test?
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
end
