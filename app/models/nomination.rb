class Nomination < ActiveRecord::Base
  belongs_to :nominee, class_name: 'User'
  belongs_to :nominator, class_name: 'User'
  has_many :votes

  validates :content, presence: true
  validates :nominee, presence: true
  validates :nominator, presence: true
end
