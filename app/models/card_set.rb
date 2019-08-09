class CardSet < ApplicationRecord
  validates :name, presence: true
  
  has_many :cards
  has_many :rating_systems
  has_many :ratings, through: :cards
end
