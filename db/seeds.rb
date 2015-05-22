require "csv"

csv_options = { headers: true, header_converters: :symbol }
CSV.foreach("./db/staff.csv", csv_options) do |row|
  user = User.find_or_initialize_by(username: row[:username])
  user.name = row[:name]
  user.provider = "github"
  puts "Saving #{user.name}"
  user.save!
  user.team_memberships.destroy_all
  user.team_memberships.find_or_create_by(team: Team.default_team)
end
