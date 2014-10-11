class Nomination < ActiveRecord::Base
  belongs_to :nominee, class_name: 'User'
  belongs_to :nominator, class_name: 'User'
  has_many :votes

  validates :content, presence: true
  validates :nominee, presence: true
  validates :nominator, presence: true

  def self.examples
    [
      "Most glorious beard",
      "Best hairdo",
      "Most help requests",
      "Fastest typer",
      "Best spectacles",
      "Best accent",
      "Most likely to `git push origin master -f`",
      "Breakable toy is already funded on Kickstarter"
    ]
  end
end
