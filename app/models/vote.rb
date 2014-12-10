class Vote < ActiveRecord::Base
  belongs_to :nomination
  belongs_to :user

  validates :nomination, presence: true
  validates :nomination, uniqueness:
    { scope: :user, message: 'You have already voted on this nomination!' }
  validates :user, presence: true
end
