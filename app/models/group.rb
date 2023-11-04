class Group < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :suggests, dependent: :destroy
  
  validates :team_name, presence: true
end
