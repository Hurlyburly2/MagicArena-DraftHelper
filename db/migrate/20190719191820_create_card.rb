class CreateCard < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_name, null: false
      
      t.string :image_url
      
      t.belongs_to :card_set
    end
  end
end
