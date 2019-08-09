class CreateRatingSystem < ActiveRecord::Migration[5.2]
  def change
    create_table :rating_systems do |t|
      t.string :name, null: false
      
      t.belongs_to :card_set
    end
  end
end
