class AddColorsAndCmcToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :colors, :string
    add_column :cards, :mana_cost, :int
  end
end
