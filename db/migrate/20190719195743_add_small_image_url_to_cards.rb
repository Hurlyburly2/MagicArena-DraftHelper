class AddSmallImageUrlToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :small_image_url, :string
  end
end
