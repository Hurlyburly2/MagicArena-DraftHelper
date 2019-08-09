class Rating < ApplicationRecord
  validates :rating, presence: true
  
  belongs_to :rating_system
  belongs_to :card
end
