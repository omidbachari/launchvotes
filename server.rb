require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'omniauth-github'

Dir[File.join(File.dirname(__FILE__), 'models', '**', '*.rb')].each do |file|
  require file
end

configure :development do
  require 'pry'
end


configure do
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET']

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end
end

#------------------------------------------ Authorization ------------------------------------------

def authorize!
  unless signed_in?
    flash[:notice] = "You need to sign in first."
    redirect '/'
  end
end

helpers do
  def current_user
    User.find(session['user_id']) if session['user_id']
  end

  def signed_in?
    !current_user.nil?
  end
end

#------------------------------------------ Routes ------------------------------------------

get '/auth/:provider/callback' do
  user = User.from_omniauth(env['omniauth.auth'])

  if user.save
    session['user_id'] = user.id
    flash[:notice] = "You have signed in as #{user.name}"
    redirect '/nominations'
  else
    flash[:error] = "There was a problem signing in."
    redirect '/'
  end
end

get '/sign_out' do
  session['user_id'] = nil
  flash[:notice] = "You have signed out"
  redirect '/'
end

get '/' do
  erb :index
end

get '/nominations' do
  authorize!
  @users = User.all
  erb :show
end

post '/nominations' do
  nominee = User.find(params[:nomination][:nominee_id])

  nomination = Nomination.new(
    nominee: nominee,
    nominator: current_user,
    content: params[:nomination][:content]
  )

  if nomination.save
    nomination.votes.create(user: current_user)
    flash[:notice] = "Your nomination has been made!"
  else
    flash[:error] = "You can't do that!"
  end
  redirect '/nominations'
end

post '/:nominations_id' do
  flash[:notice] = "You have voted!"
  redirect "/votes"
end
