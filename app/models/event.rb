class Event < ApplicationRecord
  has_many :users, dependent: :destroy

  enum mice_type: {
    meeting: 0,
    incentive_travel: 1,
    convention: 2,
    exhibition: 3
  }
  
  validates :name, presence: true
  validates :mice_type, presence: true, numericality: { only_integer: true }
end
