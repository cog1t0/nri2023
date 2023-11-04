class Event < ApplicationRecord
  has_many :users, dependent: :destroy
  
  validates :name, presence: true
  validates :mice_type, presence: true, numericality: { only_integer: true }
end
