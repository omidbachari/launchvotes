class User < ActiveRecord::Base
  has_many :nominations, foreign_key: :nominator_id
  has_many :awards, foreign_key: :nominee_id, class_name: 'Nomination'
  has_many :votes

  validates :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  validates :provider, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :pic_url, presence: true

  def self.from_omniauth(auth)
    user_attributes = {
      uid: auth.uid,
      provider: auth.provider,
      name: auth.info.name,
      email: auth.info.email,
      pic_url: auth.info.image
    }

    find_or_initialize_by(user_attributes)
  end
end
