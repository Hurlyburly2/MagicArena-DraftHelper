require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  card_text = "Profile\nDecks\nPacks\nStore\nMastery\n700\nHome\nLIN ITED\nPack 1\nPick 1\nMagic Core Set 2020\nCORE SET CA\nLeyline of Abundance\n2\nMaster Splicer\nRisen Reef\nGriffin Sentinel\nCreeping Trailblazer\nCreature Griffin\nEnchantment\nCreature Human Artificer\nM\nCreature Flemental\nCreature Elemental\nM3\n"
  
  scenario "Creating a new Screenshot- it has initializes with correct properties" do
    
    screenshot = Screenshot.new(card_text)
    
    expect(screenshot.card_text).to eq card_text
    expect(screenshot.bad_matches).to eq [
                                            "profile",
                                            "decks",
                                            "packs",
                                            "store",
                                            "home"
                                          ]
  end
  
  scenario "find_expansion pulls out the expansion associated with the card text" do
    m20_cardSet = CardSet.create(name: "M20")
    screenshot = Screenshot.new(card_text)
  
    expect(screenshot.find_expansion(card_text.split("\n"))).to eq m20_cardSet
  end
  
  scenario "find_matched_names returns the names of all cards in the pack" do
    m20_cardSet = CardSet.create(name: "M20")
  
    Card.create(card_name: "Leyline of Abundance", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
    Card.create(card_name: "Master Splicer", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
    Card.create(card_name: "Risen Reef", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
    Card.create(card_name: "Griffen Sentinel", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
    Card.create(card_name: "Creeping Trailblazer", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
    
    screenshot = Screenshot.new(card_text)
    returned_names = screenshot.find_matched_names(card_text.split("\n"))
    expect(returned_names).to eq ["Leyline of Abundance", "Master Splicer", "Risen Reef", "Creeping Trailblazer"]
  end
  
  # scenario "parse_text returns the card names from the image" do
  #   m20_cardSet = CardSet.create(name: "M20")
  # 
  #   Card.create(card_name: "Leyline of Abundance", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
  #   Card.create(card_name: "Master Splicer", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
  #   Card.create(card_name: "Risen Reef", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
  #   Card.create(card_name: "Griffen Sentinel", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
  #   Card.create(card_name: "Creeping Trailblazer", image_url: "http://dummyurl.com", card_set: m20_cardSet, small_image_url: "http://dummyurl.com", colors: "BU", mana_cost: 4)
  # 
  #   screenshot = Screenshot.new(card_text)
  #   returned_names = screenshot.parse_text
  #   expect(returned_names).to eq ["Leyline of Abundance", "Master Splicer", "Risen Reef", "Creeping Trailblazer"]
  # end
end
