class Icon < ApplicationRecord
    has_one :user
  
    validates :image_url, presence: true
end
