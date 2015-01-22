class User < ActiveRecord::Base
  has_many :nominations, foreign_key: :nominator_id
  has_many :awards, foreign_key: :nominee_id, class_name: 'Nomination'
  has_many :votes
  belongs_to :github_team

  validates :uid, presence: true
  validates :provider, presence: true
  validates :pic_url, presence: true
  validates :username, presence: true

  validates :provider, inclusion: { in: ['github'] }
  validates :role, inclusion: { in: ['user', 'admin'] }

  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    user_attributes = {
      username: auth.info.nickname,
      email: auth.info.email,
      pic_url: auth.info.image,
      github_token: auth.credentials.token
    }

    user = find_or_initialize_by(uid: auth.uid, provider: auth.provider)
    user.assign_attributes(user_attributes)
    user
  end

  def is_admin?
    role == 'admin'
  end

  def display_name
    name || username
  end
end
