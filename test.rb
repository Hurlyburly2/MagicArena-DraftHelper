require 'pry'
require "google/cloud/vision"


vision = Google::Cloud::Vision.new
binding.pry
image = vision.image "eternal_draft.png"

puts image.text

binding.pry
