class Icon < ApplicationRecord
    has_one :user
  
    validates :image_url, presence: true, url: true
end
