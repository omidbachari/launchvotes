class Vote < ActiveRecord::Base
  belongs_to :nomination, counter_cache: true
  belongs_to :user

  validates :nomination, presence: true
  validates :nomination, uniqueness:
    { scope: :user, message: 'You have already voted on this nomination!' }
  validates :user, presence: true

  validate :nomination_is_votable
  validate :nominator_cannot_vote_on_nomination

  def nomination_is_votable
    if nomination && !nomination.votable?
      errors.add(:nomination, "Voting on this nomination has expired.")
    end
  end

  def nominator_cannot_vote_on_nomination
    if nomination && nomination.nominator == user
      errors.add(:nomination, "You made this nomination. Your vote does not count!")
    end
  end
end
