class User < ActiveRecord::Base
  has_many :nominations, foreign_key: :nominator_id
  has_many :awards, foreign_key: :nominee_id, class_name: 'Nomination'
  has_many :votes
  has_many :team_memberships
  has_many :teams, through: :team_memberships

  validates :username, presence: true

  validates :provider, inclusion: { in: ['github'] }
  validates :role, inclusion: { in: ['user', 'admin'] }

  def self.from_omniauth(auth)
    user_attributes = {
      email: auth.info.email,
      pic_url: auth.info.image,
      name: auth.info.name
    }

    user = find_or_create_by(uid: auth.uid, provider: auth.provider)
    user.assign_attributes(user_attributes) if user
    user
  end

  def admin?
    role == 'admin'
  end

  def display_name
    name || username
  end

  def display_image
    pic_url || "http://placegoat.com/300/300"
  end
end
