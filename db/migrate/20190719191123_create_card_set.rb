class CreateCardSet < ActiveRecord::Migration[5.2]
  def change
    create_table :card_sets do |t|
      t.string :name, null: false
    end
  end
end
