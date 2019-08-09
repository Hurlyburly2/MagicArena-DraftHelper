class CreateRating < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.float :rating, null: false
      
      t.belongs_to :card
      t.belongs_to :rating_system
    end
  end
end
