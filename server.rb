require "sinatra"
require "pry"
require "pg"

#methods

def db_connection
  begin
    connection = PG.connect(dbname: 'launchvotes')
    yield(connection)
  ensure
    connection.close
  end
end

def get_award_info
  connection = PG.connect(dbname: 'launchvotes')
  award_info = connection.exec('SELECT nominations.content, nominations.created_at, users.name, users.pic_url FROM nominations LEFT JOIN users ON users.id = nominations.nominee_id ORDER BY nominations.created_at')
  connection.close
  award_info.to_a
end

def get_names
  connection = PG.connect(dbname: 'launchvotes')
  names = connection.exec('SELECT * FROM users')
  connection.close
  names
end

def add_award_info(nominations_content, nominee_id)
  connection = PG.connect(dbname: 'launchvotes')
  sql = "INSERT INTO nominations (content, created_at, nominee_id) VALUES ($1, now(), $2)"
  db_connection do |conn|
    conn.exec_params(sql,[nominations_content,nominee_id])
  end
end

#http

get '/' do
  @users = get_names
  @get_award_info = get_award_info

  erb :index
end

post '/' do
  add_award_info(params["nominations_content"], params["nominee_id"].to_i)

  redirect '/'
end
