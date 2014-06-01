require "sinatra"
require "pry"
require "pg"

#methods


#http

get '/' do
  erb :index
end

post '/' do

  redirect '/'
end
