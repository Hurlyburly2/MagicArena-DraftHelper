# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#CALL THIS TO GET CARDS
# https://api.scryfall.com/cards/search?q=set=m20

m20_sources = ["https://api.scryfall.com/cards/search?q=set=m20", "https://api.scryfall.com/cards/search?q=set=m20&page=2"]

m20_cards = []
m20_sources.each do |source|
  response = HTTParty.get(source)
  parsed_response = JSON.parse(response.body)
  m20_cards += parsed_response["data"]
end

CardSet.create(name: "M20")
m20_cardset = CardSet.find_by(name: "M20")

m20_cards.each do |card|
  colors = ""
  if card["colors"].length > 0
    colors = card["colors"].join('')
  else
    colors = "X"
  end
  Card.create(card_name: card["name"], image_url: card["image_uris"]["normal"], card_set: m20_cardset, small_image_url: card["image_uris"]["small"], colors: colors, mana_cost: card["cmc"])
end

rating_systems = {  
  "Frank Karsten" => ["https://docs.google.com/spreadsheets/d/e/2PACX-1vSPxdaJM8upl-NfusKLSugfEgwHEOqfk464BndB0xvDbOj912dVJ7u0Tq7xNWV-TLNc0MFvPQ8wWgvY/pubhtml"],
  "Luis Scott-Vargas" => [
    "https://www.channelfireball.com/articles/core-set-2020-limited-set-review-gold-artifacts-and-lands/",
    "https://www.channelfireball.com/articles/core-set-2020-limited-set-review-white/", 
    "https://www.channelfireball.com/articles/core-set-2020-limited-set-review-green-and-gold/", 
    "https://www.channelfireball.com/articles/core-set-2020-limited-set-review-red/",
    "https://www.channelfireball.com/home/core-set-2020-limited-set-review-black/",
    "https://www.channelfireball.com/articles/core-set-2020-limited-set-review-blue/"],
  "Draftaholics Anonymous" => ["https://apps.draftaholicsanonymous.com/p1p1/M20"],
  "Justlolaman" => ["https://docs.google.com/spreadsheets/d/1VFew8_ybQBhg1R3iQHzztPEtYNH4Ma8T8yM9EH5G688/edit?usp=sharing"]
}

# "cricketHunter Limited Community Polling" => "https://www.mtgcommunityreview.com/core-set-2020",

rating_systems.each do |system|
  new_system = RatingSystem.create(name: system[0], card_set: m20_cardset, urls: system[1])
  RatingSystem.get_ratings(new_system)
end
