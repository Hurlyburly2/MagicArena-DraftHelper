# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_02_174343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sets", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "card_name", null: false
    t.string "image_url"
    t.bigint "card_set_id"
    t.string "small_image_url"
    t.string "colors"
    t.integer "mana_cost"
    t.index ["card_set_id"], name: "index_cards_on_card_set_id"
  end

  create_table "rating_systems", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "card_set_id"
    t.string "urls"
    t.index ["card_set_id"], name: "index_rating_systems_on_card_set_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.float "rating", null: false
    t.bigint "card_id"
    t.bigint "rating_system_id"
    t.index ["card_id"], name: "index_ratings_on_card_id"
    t.index ["rating_system_id"], name: "index_ratings_on_rating_system_id"
  end

  create_table "screenshots", force: :cascade do |t|
    t.string "url"
    t.string "draft_photo"
  end

end
