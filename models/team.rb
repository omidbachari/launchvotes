class Team < ActiveRecord::Base
  has_many :team_memberships
  has_many :users, through: :team_memberships

  validates :name, presence: true

  def self.default_team
    find_or_create_by(name: "Launchers")
  end

  def self.current_team
    find_or_create_by(name: "Fall 2015")
  end
end
