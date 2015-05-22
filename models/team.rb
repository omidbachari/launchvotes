class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :users, through: :team_memberships

  validates :name, presence: true

  def self.default_team
    find_or_create_by(name: "Launchers")
  end
end
