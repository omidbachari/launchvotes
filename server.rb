# dotenv loads variables from a .env file into ENV when the environment is bootstrapped.
require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'omniauth-github'
require 'omniauth-facebook'
require 'pg'

require_relative 'models/user'


configure :development do
  require 'pry'
end


configure do
  enable :sessions

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
    scope: 'read:org'
  end
end

#------------------------------------------ Database Config ------------------------------------------
def production_database_config
  db_url_parts = ENV['DATABASE_URL'].split(/\/|:|@/)

  {
    user: db_url_parts[3],
    password: db_url_parts[4],
    host: db_url_parts[5],
    dbname: db_url_parts[7]
  }
end

configure :development do
  set :database_config, { dbname: 'launchvotes' }
end

configure :production do
  set :database_config, production_database_config
end

def db_connection
  begin
    connection = PG.connect(settings.database_config)
    yield(connection)
  ensure
    connection.close
  end
end

#------------------------------------------ Authorization ------------------------------------------
# Unless the user is signed in, they will not be able to visit the page with votes
def authorize!
  unless signed_in?
    flash[:notice] = "You need to sign in first."
    redirect '/'
  end
end

helpers do
  def current_user
    # Change to read from database
    @current_user ||= session['uid']
  end

  # As long as the output from our method above (current_user) is NOT nil, then the user is signed in
  def signed_in?
    !current_user.nil?
  end
end

#------------------------------------------ Methods ------------------------------------------

def display_votes?
  true
end

def current_week
  week = 604800
  current_week_noms = []
  connection = PG.connect(settings.database_config)
  if display_votes?
    nominations = connection.exec('SELECT nominations.nominee_id, nominations.id, nominations.votes, nominations.content,
                                  nominations.created_at, users.name, users.pic_url FROM nominations
                                  LEFT JOIN users ON users.uid = nominations.nominee_id
                                  ORDER BY nominations.votes DESC').to_a
  else
    nominations = connection.exec('SELECT nominations.nominee_id, nominations.id, nominations.votes, nominations.content,
                                  nominations.created_at, users.name, users.pic_url FROM nominations
                                  LEFT JOIN users ON users.uid = nominations.nominee_id
                                  ORDER BY nominations.created_at DESC').to_a
  end
  current_time = connection.exec('SELECT EXTRACT( EPOCH FROM now())').first

  nominations.each do |nomination|
    created_sql = "SELECT EXTRACT(EPOCH FROM TIMESTAMP '#{nomination["created_at"]}')"
    created = connection.exec(created_sql).first

    if current_time["date_part"].to_f - created["date_part"].to_f < week
      current_week_noms << nomination
    end
  end
  current_week_noms
end

def intro_award_info
  week = 604800
  last_week = 604800*2
  last_week_noms = []
  connection = PG.connect(settings.database_config)
  nominations = connection.exec('SELECT nominations.nominee_id, nominations.id, nominations.votes, nominations.content,
                                nominations.created_at, users.name, users.pic_url FROM nominations
                                LEFT JOIN users ON users.uid = nominations.nominee_id
                                ORDER BY nominations.votes DESC')
  current_time = connection.exec('SELECT EXTRACT( EPOCH FROM now())').first

  nominations.each do |nomination|
    created_sql = "SELECT EXTRACT(EPOCH FROM TIMESTAMP '#{nomination["created_at"]}')"
    created = connection.exec(created_sql).first

    date_check = current_time["date_part"].to_f - created["date_part"].to_f
    if date_check > week && date_check < last_week
      last_week_noms << nomination
    end
  end
  last_week_noms.take(4)
end

def get_names
  connection = PG.connect(settings.database_config)
  names = connection.exec('SELECT * FROM users ORDER BY name')
  connection.close
  names
end

def add_award_info(nominations_content, votes, nominee_id)
  connection = PG.connect(settings.database_config)
  sql = "INSERT INTO nominations (content, votes, created_at, nominee_id) VALUES ($1, $2, now(), $3)"
  db_connection do |conn|
    conn.exec_params(sql,[nominations_content, votes, nominee_id])
  end
end

def upvote_comment(id)
  sql = 'UPDATE nominations SET votes = votes+1 WHERE id = $1'
  db_connection do |conn|
    conn.exec_params(sql,[id])
  end
end

# Method that cycles thru the array of hashes for all uid's in our database
def include_uid?(uid, data)
  data.each do |hash|
    return true if hash["uid"] == uid
  end
  false
end

def find_or_create(attributes)
  connection = PG.connect(settings.database_config)
  uids = connection.exec('SELECT uid FROM users')
  uids = uids.to_a

  if !include_uid?(attributes[:uid], uids)
    sql = "INSERT INTO users (uid, email, pic_url, name) VALUES ($1, $2, $3, $4)"
    connection.exec_params(sql, [attributes[:uid], attributes[:email], attributes[:avatar_url], attributes[:name]])
  end
end

#------------------------------------------ Routes ------------------------------------------
get '/' do
  @teaser_awards = intro_award_info
  erb :index
end

get '/votes' do
  @display = display_votes?
  @uid = session["uid"]
  authorize!
  @users = get_names
  @get_award_info = current_week
  erb :show
end

get '/auth/:provider/callback' do
  # This is returns a hash with all of the information sent back by the
  # service (Github or Facebook)
  auth = env['omniauth.auth']
  # auth_token =

  # Build a hash that represents the user from the info given back from either
  # Facebook or Github
  user_attributes = {
    name: auth['info']['name'],
    uid: auth['uid'],
    email: auth['info']['email'],
    avatar_url: auth['info']['image']
  }

  find_or_create(user_attributes)
  # user = User.create(user_attributes)

  # Save the id of the user that's logged in inside the session
  session["uid"] = user_attributes[:uid]
  session["pic"] = user_attributes[:avatar_url]
  flash[:notice] = "You have signed in as #{user_attributes[:name]}"
  redirect '/votes'
end

get '/sign_out' do
  # Sign the user out by removing the id from the session
  session["uid"] = nil
  flash[:notice] = "You have signed out"
  redirect '/'
end


post '/' do
  add_award_info(params["nominations_content"], 0, params["nominee_id"].to_i)
  flash[:notice] = "You're nomination has been made!"
  redirect '/votes'
end

post '/:nominations_id' do
  flash[:notice] = "You have voted!"
  # Update comments.vote +1 where params["comment"] =  comments.id
  upvote_comment(params[:nominations_id])
  redirect "/votes"
end

