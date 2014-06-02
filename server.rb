
require 'sinatra'
require 'pg'

#methods


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

# def db_connection
#   begin
#     connection = PG.connect(dbname: 'launchvotes')
#     yield(connection)
#   ensure
#     connection.close
#   end
# end

def get_award_info
  connection = PG.connect(dbname: 'launchvotes')
  award_info = connection.exec('SELECT nominations.id, nominations.votes, nominations.content, nominations.created_at, users.name, users.pic_url FROM nominations LEFT JOIN users ON users.id = nominations.nominee_id ORDER BY nominations.votes DESC')
  connection.close
  award_info.to_a
end

def get_names
  connection = PG.connect(dbname: 'launchvotes')
  names = connection.exec('SELECT * FROM users')
  connection.close
  names
end

def add_award_info(nominations_content, votes, nominee_id)
  connection = PG.connect(dbname: 'launchvotes')
  sql = "INSERT INTO nominations (content, votes, created_at, nominee_id) VALUES ($1, $2, now(), $3)"
  db_connection do |conn|
    conn.exec_params(sql,[nominations_content, votes, nominee_id])
  end
end

def upvote_comment(add_one, id)
  sql = 'UPDATE nominations SET votes = $1 WHERE id = $2'
  db_connection do |conn|
    conn.exec_params(sql,[add_one,id])
  end
end

#http

get '/' do
  @users = get_names
  @get_award_info = get_award_info
  erb :index
end

post '/' do
  add_award_info(params["nominations_content"], 0, params["nominee_id"].to_i)

  redirect '/'
end

post '/:nominations_id' do
  # Update comments.vote +1 where params["comment"] =  comments.id
  upvote_comment(params["plus_one"], params[:nominations_id])
  redirect "/"
end

