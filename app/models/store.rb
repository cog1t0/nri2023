class Store < ApplicationRecord
  has_many :suggests, dependent: :destroy
  
  validates :name, presence: true
  validates :business_type, presence: true, numericality: { only_integer: true }
end
