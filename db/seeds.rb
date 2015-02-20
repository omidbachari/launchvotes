require "csv"

files = %w(./db/winter_2014.csv ./db/spring_2015.csv)

files.each do |file|
  team_name = File.basename(files.first, ".csv").titleize
  team = Team.find_or_create_by(name: team_name)

  CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
    user = User.find_or_initialize_by(username: row[:username])
    user.name = row[:name]
    user.provider = "github"
    user.save!
    team.users << user
  end
end
