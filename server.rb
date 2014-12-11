require 'dotenv'
Dotenv.load

require 'octokit'
require 'omniauth-github'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sanitize'

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

#--- Authorization ---

def authorize!
  unless signed_in?
    flash[:notice] = "You need to sign in first."
    redirect '/'
  end
end

def authorize_admin!
  if !signed_in? || !current_user.is_admin?
    flash[:notice] = "You are not authorized to view this resource!"
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

#--- Routes ---

get '/auth/:provider/callback' do
  user = User.from_omniauth(env['omniauth.auth'])
  if user.save
    session['user_id'] = user.id
    flash[:notice] = "You have signed in as #{user.display_name}"
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
  redirect '/nominations' if current_user
  erb :index
end

get '/nominations' do
  authorize!
  @users = User.order(:name)

  if params[:weeks_ago]
    @nominations = Nomination.weeks_ago(params[:weeks_ago].to_i)
      .includes(:nominee)
      .order(votes_count: :desc)
  else
    @nominations = Nomination.this_week
      .includes(:nominee)
      .where.not(nominee: current_user)
      .order(votes_count: :desc)
  end

  erb :nominations
end

post '/nominations' do
  authorize!
  nominee = User.find(params[:nomination][:nominee_id])
  content = Sanitize.fragment(params[:nomination][:content], Sanitize::Config::RESTRICTED)

  nomination = Nomination.new(
    nominee: nominee,
    nominator: current_user,
    content: content
  )

  if nomination.save
    nomination.votes.create(user: current_user)
    flash[:notice] = "Your nomination has been made!"
  else
    flash[:error] = nomination.errors.full_messages.join
  end
  redirect '/nominations'
end

post '/nominations/:id/vote' do
  authorize!
  nomination = Nomination.find(params[:id])
  vote = nomination.votes.build(user: current_user)
  if vote.save
    flash[:notice] = "You have voted!"
  else
    flash[:error] = vote.errors.full_messages.join
  end
  redirect "/nominations"
end

get '/teams' do
  authorize_admin!
  GithubTeam.fetch_teams(current_user.github_token)
  @github_teams = GithubTeam.all
  erb :teams
end

post '/teams' do
  authorize_admin!
  github_team = GithubTeam.find(params[:github_team][:id])
  github_team.fetch_members(current_user.github_token)

  flash[:notice] = "Members of '#{github_team.name}' added successfully!"
  redirect '/nominations'
end
