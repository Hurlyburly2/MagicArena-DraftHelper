require "fuzzy_match"

class Screenshot < ApplicationRecord
  # mount_uploader :url, DraftImageUploader
  mount_uploader :draft_photo, DraftPhotoUploader
  
  attr_reader :card_text, :bad_matches
  
  def initialize(card_text)
    @card_text = card_text
    @bad_matches = [
      "profile",
      "decks",
      "packs",
      "store",
      "home"
    ]
  end
  
  def parse_text
    split_text = @card_text.split("\n")
    
    matched_names = find_matched_names(split_text)
    return get_card_data(matched_names)
  end
  
  def get_card_data(matched_names)
    card_objects = {}
    matched_names.each do |card_name|
      current_card = Card.find_by(card_name: card_name)
      found_ratings = current_card.ratings
      current_card_ratings = {}
      found_ratings.each do |rating|
        current_card_ratings[rating.rating_system.id] = {
                                      rating_id: rating.id,
                                      rating: rating.rating,
                                      rating_system_id: rating.rating_system.id,
                                      rating_system_name: rating.rating_system.name
                                    }
      end
      card_objects[current_card[:id]] = {
                                          card: {
                                                    id: current_card.id,
                                                    name: current_card.card_name,
                                                    image_url: current_card.image_url,
                                                    small_image_url: current_card.small_image_url,
                                                    colors: current_card.colors.split(''),
                                                    mana_cost: current_card.mana_cost
                                                }, 
                                          ratings: current_card_ratings
                                        }
    end
    return card_objects
  end
  
  def find_matched_names(split_text)
    current_cardset = find_expansion(split_text)
    card_names = current_cardset.cards.pluck(:card_name)
    matches = []
    matcher = FuzzyMatch.new(card_names, :threshold => 0.99, :must_match_at_least_one_word => true)
    
    split_text.each do |word|
      if !@bad_matches.include?(word.downcase)
        found_card = matcher.find(word)
        if found_card != nil && found_card != "Swamp" && found_card != "Island" && found_card != "Mountain" && found_card != "Plains" && found_card != "Forest"
          matches << found_card
        end
      end
    end
    
    return matches
  end
  
  def find_expansion(split_text)
    expansions = ["Magic Core Set 2020", "War of the Spark"]
    found_expansion = ""
    expansions.each do |expansion_name|
      if split_text.include?(expansion_name)
        found_expansion = expansion_name
        break
      end
    end
    
    expansion_code = ""
    case found_expansion
    when "Magic Core Set 2020"
      expansion_code = "M20"
    end
    return CardSet.find_by(name: expansion_code)
  end
end
