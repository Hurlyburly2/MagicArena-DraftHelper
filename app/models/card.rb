class Card < ApplicationRecord
  validates :card_name, presence: true
  
  belongs_to :card_set
  has_many :ratings
end
