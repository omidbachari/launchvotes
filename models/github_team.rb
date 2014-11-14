class GithubTeam < ActiveRecord::Base
  has_many :users

  validates :name, presence: true
  validates :tid, presence: true

  def self.fetch_teams(token)
    client = Octokit::Client.new(access_token: token)
    teams = client.user_teams
    teams.each do |team|
      find_or_create_by(tid: team.id, name: team.name)
    end
    teams
  end

  def fetch_members(token)
    client = Octokit::Client.new(access_token: token)
    members = client.team_members(tid)
    members.each do |member|
      user = User.find_or_create_by(
        uid: member.id,
        provider: 'github',
        username: member.login,
        pic_url: member.avatar_url,
        github_team_id: id
      )
    end
  end
end
