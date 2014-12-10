require 'csv'

client = Octokit::Client.new(client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'])

CSV.foreach('./db/winter_2014.csv', headers: true, header_converters: :symbol) do |row|
  github_user = client.user(row[:username])
  user = User.find_or_initialize_by(username: row[:username])
  user.uid = github_user[:id]
  user.provider = 'github'
  user.name = row[:name]
  user.email = github_user[:email]
  user.pic_url = github_user[:avatar_url]
  user.save!
end
