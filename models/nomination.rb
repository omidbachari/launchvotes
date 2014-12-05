class Nomination < ActiveRecord::Base
  belongs_to :nominee, class_name: 'User'
  belongs_to :nominator, class_name: 'User'
  has_many :votes

  validates :content, presence: true
  validates :content, uniqueness: { scope: :nominee,
    message: "Duplicate nomination detected! Submission rejected."}

  validates :nominee, presence: true
  validates :nominator, presence: true
  validate :nominee_cannot_be_nominator

  def nominee_cannot_be_nominator
    if nominee == nominator
      errors.add(:nominee, 'Egotistical nomination detected! Submission rejected.')
    end
  end

  def self.examples
    [
      "Most glorious beard",
      "Best hairdo",
      "Most help requests",
      "Fastest typer",
      "Best spectacles",
      "Best accent",
      "Most likely to `git push origin master -f`",
      "Breakable toy is funded on Kickstarter"
    ]
  end

  def self.this_week
    weeks_ago(0)
  end

  def self.last_week
    weeks_ago(1)
  end

  def self.weeks_ago(num)
    day = num.weeks.ago
    week_start = day.beginning_of_week
    week_end = day.end_of_week
    where(created_at: week_start..week_end)
  end
end
