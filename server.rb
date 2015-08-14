require 'dotenv'
Dotenv.load

require 'omniauth-github'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sanitize'
require './lib/image'

Dir[File.join(File.dirname(__FILE__), 'models', '**', '*.rb')].each do |file|
  require file
end

set :host, ENV["HOSTNAME"]

configure :development, :test do
  require 'pry'
end

configure :production do
  require 'rack/ssl'
  use Rack::SSL
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
    redirect to('/')
  end
end

def authorize_admin!
  if !signed_in? || !current_user.admin?
    flash[:notice] = "You are not authorized to view this resource!"
    redirect to('/')
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

  if user && user.save
    user.team_memberships.find_or_create_by(team: Team.current_team)
    session['user_id'] = user.id
    flash[:notice] = "You have signed in as #{user.display_name}"
    redirect to('/nominations')
  else
    flash[:error] = "There was a problem signing in."
    redirect to('/')
  end
end

get '/sign_out' do
  session['user_id'] = nil
  flash[:notice] = "You have signed out"
  redirect to('/')
end

get '/' do
  redirect to('/nominations') if current_user
  erb :index
end

get '/awards' do
  authorize_admin!

  @nominations = Nomination.this_week
    .includes(:nominee)
    .where('votes_count > 0')
    .order(votes_count: :asc)

  erb :awards
end

get '/nominations' do
  authorize!

  team_ids = current_user.teams.pluck(:team_id)
  @users = User.uniq
    .joins(:team_memberships)
    .where(team_memberships: { team_id: team_ids })
    .order(:name)

  @nominations = Nomination.this_week
    .includes(:nominee)
    .where.not(nominee: current_user)
    .order(content: :asc)

  erb :nominations
end

get '/nominations/:weeks/weeks_ago' do |weeks|
  @nominations = Nomination.weeks_ago(weeks.to_i)
    .includes(:nominee)
    .where('votes_count > 0')
    .order(votes_count: :desc)

  erb :awards
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
  redirect to('/nominations')
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
  redirect to('/nominations')
end
