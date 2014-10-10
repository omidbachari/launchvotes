class Nomination < ActiveRecord::Base
  belongs_to :nominee, class_name: 'User', foreign_key: :nominee_id
  belongs_to :nominator, class_name: 'User', foreign_key: :nominator_id
  has_many :votes

  validates :content, presence: true
  validates :nominee, presence: true
  validates :nominator, presence: true
end
