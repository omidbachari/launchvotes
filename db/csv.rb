require 'csv'
require 'pry'

users = []
CSV.foreach('spring.csv', headers: true) do |row|
  user = {}
  user[:name] = "#{row["First"]} #{row["Last"]}"
  user[:username] = row["Github"]
  users << user
end

File.open('spring_2015.csv', 'w') do |file|
  file.puts "name,username"
  users.each do |user|
    file.puts "#{user[:name]},#{user[:username]}"
  end
end
