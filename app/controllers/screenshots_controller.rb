require "google/cloud/vision"
require "fuzzy_match"

class ScreenshotsController < ApplicationController
  def index
    
  end
  
  def create
    # vision = Google::Cloud::Vision.new
    # card_text = vision.image params["screenshot"]["draft_photo"].tempfile.path
    # card_text = card_text.text
    # 
    # #FUZZY MATCH TEST STUFF:
    # test_word = FuzzyMatch.new(['jaslfdkjsdfal', 'sothngsah', 'fjsdlaj']).find('something')
    # 
    # binding.pry
  end
end
