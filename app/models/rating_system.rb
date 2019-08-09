class RatingSystem < ApplicationRecord
  validates :name, presence: true
  belongs_to :card_set
  
  has_many :ratings
  
  def get_url
    this.url.split(', ')
  end
  
  def self.get_ratings(rating_system)
    urls = JSON.parse(rating_system.urls)
    
    url_counter = 0
    urls.each do |url|
      if (rating_system.name == "Frank Karsten")
        data = getFrankKarstenRatings(rating_system)
      elsif (rating_system.name == "Luis Scott-Vargas")
        getLSVWebCrawl(url, rating_system, url_counter)
        url_counter += 1
      elsif (rating_system.name == "Draftaholics Anonymous")
        getDraftAnonWebCrawl(url, rating_system)
      elsif (rating_system.name == "Justlolaman")
        drifter_system = RatingSystem.create(name: "Drifter", card_set: CardSet.find_by(name: "M20"), urls: rating_system.urls)
        getJustlolamanAndDrifter(rating_system, drifter_system)
      end
    end
    
    if rating_system.name == "Luis Scott-Vargas"
      LSVAddLands(rating_system)
    end
  end
  
  def self.getJustlolamanAndDrifter(justlolaman_sys, drifter_sys)
    session = GoogleDrive::Session.from_config("config.json")
    spreadsheet = session.spreadsheet_by_key("1VFew8_ybQBhg1R3iQHzztPEtYNH4Ma8T8yM9EH5G688").worksheets[0]
    
    ratingsJ = []
    ratingsD = []
    
    row = 1
    col_white = 1
    col_blue = 7
    col_green = 13
    col_red = 19
    col_black = 25
    col_multi = 31
    bad_matches = ["WHITE", "BLUE", "GREEN", "RED", "BLACK", "MULTICOLOR", "COLORLESS", "UTILITY LANDS", ""]
    while row < 68
      if !bad_matches.include?(spreadsheet[row, col_white + 2])
        current_j_rating = scaleRating(letterToNumber(spreadsheet[row, col_white]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_d_rating = scaleRating(letterToNumber(spreadsheet[row, col_white + 1]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_card = spreadsheet[row, col_white + 2]
        ratingsJ << [current_card, current_j_rating]
        ratingsD << [current_card, current_d_rating]
      end
      
      if !bad_matches.include?(spreadsheet[row, col_blue + 2])
        current_j_rating = scaleRating(letterToNumber(spreadsheet[row, col_blue]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_d_rating = scaleRating(letterToNumber(spreadsheet[row, col_blue + 1]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_card = spreadsheet[row, col_blue + 2]
        ratingsJ << [current_card, current_j_rating]
        ratingsD << [current_card, current_d_rating]
      end
      
      if row < 45 && !bad_matches.include?(spreadsheet[row, col_green + 2])
        current_j_rating = scaleRating(letterToNumber(spreadsheet[row, col_green]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_d_rating = scaleRating(letterToNumber(spreadsheet[row, col_green + 1]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_card = spreadsheet[row, col_green + 2]
        ratingsJ << [current_card, current_j_rating]
        ratingsD << [current_card, current_d_rating]
      end
      
      if row < 45 && !bad_matches.include?(spreadsheet[row, col_red + 2])
        current_j_rating = scaleRating(letterToNumber(spreadsheet[row, col_red]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_d_rating = scaleRating(letterToNumber(spreadsheet[row, col_red + 1]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_card = spreadsheet[row, col_red + 2]
        ratingsJ << [current_card, current_j_rating]
        ratingsD << [current_card, current_d_rating]
      end
      
      if row < 45 && !bad_matches.include?(spreadsheet[row, col_black + 2])
        current_j_rating = scaleRating(letterToNumber(spreadsheet[row, col_black]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_d_rating = scaleRating(letterToNumber(spreadsheet[row, col_black + 1]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_card = spreadsheet[row, col_black + 2]
        ratingsJ << [current_card, current_j_rating]
        ratingsD << [current_card, current_d_rating]
      end
      
      if row < 45 && !bad_matches.include?(spreadsheet[row, col_multi + 2])
        current_j_rating = scaleRating(letterToNumber(spreadsheet[row, col_multi]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_d_rating = scaleRating(letterToNumber(spreadsheet[row, col_multi + 1]).to_f, 0.0, 5.0, 0, 12).round(2)
        current_card = spreadsheet[row, col_multi + 2]
        ratingsJ << [current_card, current_j_rating]
        ratingsD << [current_card, current_d_rating]
      end
      
      row += 1
    end
    
    index = 0
    while index < ratingsJ.length do
      current_card = ratingsJ[index][0]
      card = Card.find_by(card_name: current_card)
      
      Rating.create(rating: ratingsJ[index][1], card: card, rating_system: justlolaman_sys)
      Rating.create(rating: ratingsD[index][1], card: card, rating_system: drifter_sys)
      
      index += 1
    end
  end
  
  def self.scaleRating(unscaledNum, minAllowed, maxAllowed, min, max)
    return (maxAllowed - minAllowed) * (unscaledNum - min) / (max - min) + minAllowed
  end
  
  def self.letterToNumber(letter)
    case letter
    when "A+"
      return 12
    when "A"
      return 11
    when "A-"
      return 10
    when "B+"
      return 9
    when "B"
      return 8
    when "B-"
      return 7
    when "C+"
      return 6
    when "C"
      return 5
    when "C-"
      return 4
    when "D+"
      return 3
    when "D"
      return 2
    when "D-"
      return 1
    when "F"
      return 0
    end
  end
  
  def self.getDraftAnonWebCrawl(url, rating_system)
    page = ""
    File.open('lib/data/draftaholicsanonymous.txt').each do |line|
      page += line
    end
    
    page = page.split("</tr><tr")
    
    cards = []
    highest_rating = 0
    lowest_rating = 10000
    page.each do |line|
      line = line.split('</span></td><td>')[1]
      line = line.split('</td><td>')
      line[1] = line[1].match(/\d+/).to_s.to_i
      if line[1] > highest_rating
        highest_rating = line[1]
      end
      if line[1] < lowest_rating
        lowest_rating = line[1]
      end
      cards << line
    end
    
    cards.each do |card|
      card[1] = scaleRating(card[1].to_f, 0.0, 5.0, lowest_rating.to_f, highest_rating.to_f).round(2)
      found_card = Card.find_by(card_name: card[0])
      Rating.create(rating: card[1].to_f, card: found_card, rating_system: rating_system)
    end
  end
  
  def self.getLSVWebCrawl(url, rating_system, url_counter)
    encoded_url = URI.encode(url)
    uri = URI.parse(encoded_url)
    page = Nokogiri::HTML(open(uri))
    
    card_names = page.css("h2").to_s   #pulls card names
    card_names = card_names.split("</h2><h2>Top")[0]
    card_names[0..3] = ""
    card_names = card_names.split("</h2><h2>")
    
    card_ratings = page.css("h3").to_s   #pulls card ratings
    card_ratings = card_ratings.split("</h3><h3 class=")[0]
    card_ratings[0..3] = ""
    card_ratings = card_ratings.split("</h3><h3>")
    card_ratings.shift
  
    cards_with_ratings = {}
    if url_counter == 0
      card_ratings = card_ratings.select { |rating| !rating.include?("Flavor") }
      
      card_names = card_names.select { |name| name != "Artifacts" }
      index_of_lifegain_lands = card_names.index { |name| name.include?("Bloodfell Caves") }
      card_names = card_names[0..(index_of_lifegain_lands - 1)]
      
      card_names.each_with_index do |name, index|
        card_ratings[index] = card_ratings[index].split(" // ")[0]
        card_ratings[index] = card_ratings[index].split(": ")[1]
        cards_with_ratings[name] = card_ratings[index].to_f
      end
      
    else
      card_ratings = card_ratings.select { |rating| !rating.include?("Flavor") }
      
      card_names.each_with_index do |name, index|
        card_ratings[index] = card_ratings[index].split(" // ")[0]
        card_ratings[index] = card_ratings[index].split(": ")[1]
        cards_with_ratings[name] = card_ratings[index].to_f
      end
    end
    
    cards_with_ratings.each do |card|
      found_card = Card.find_by(card_name: card[0])
      Rating.create(rating: card[1].to_f, card: found_card, rating_system: rating_system)
    end
  end
  
  def self.LSVAddLands(rating_system)
    if (rating_system.name == "Luis Scott-Vargas")
      # Lands manually entered due to wonky website setup (ugh)
      lands = {
        "Bloodfell Caves" => 3.0,
        "Blossoming Sands" => 3.0,
        "Cryptic Caves" => 3.0,
        "Dismal Backwater" => 3.0,
        "Evolving Wilds" => 3.0,
        "Field of the Dead" => 0.0,
        "Jungle Hollow" => 3.0,
        "Lotus Field" => 2.0,
        "Rugged Highlands" => 3.0,
        "Scoured Barrens" => 3.0,
        "Swiftwater Cliffs" => 3.0,
        "Temple of Epiphany" => 3.5,
        "Temple of Malady" => 3.5,
        "Temple of Mystery" => 3.5,
        "Temple of Silence" => 3.5,
        "Temple of Triumph" => 3.5,
        "Thornwood Falls" => 3.0,
        "Tranquil Cove" => 3.0,
        "Wind-Scarred Crag" => 3.0
      }
      
      lands.each do |card|
        found_card = Card.find_by(card_name: card[0])
        Rating.create(rating: card[1].to_f, card: found_card, rating_system: rating_system)
      end
    end
  end
  
  def self.getFrankKarstenRatings(rating_system)
    session = GoogleDrive::Session.from_config("config.json")
    spreadsheet = session.spreadsheet_by_key("1DqbBD_xI8Lr3KwZgYMhevC5M43sYQ-WVjYQffBqqTgU").worksheets[0]
    rows = spreadsheet.rows
    rows[1..rows.length-1].each do |row|
      card = Card.find_by(card_name: row[0])
      Rating.create(rating: row[4].to_f, card: card, rating_system: rating_system)
    end
  end
end
