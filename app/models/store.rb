class Store < ApplicationRecord
  has_many :suggests, dependent: :destroy
  
  validates :name, presence: true
  validates :business_type, presence: true, numericality: { only_integer: true }
#   validates :description, length: { maximum: 500 }, allow_blank: true
  validates :link_url, url: true, allow_blank: true
end
