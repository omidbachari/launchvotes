class Vote < ActiveRecord::Base
  belongs_to :nomination
  belongs_to :user

  validates :nomination, presence: true
  validates :user, presence: true
  validates :user, uniqueness: { scope: :nomination }
end
