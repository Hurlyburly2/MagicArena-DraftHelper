class ImageTable < ActiveRecord::Migration[5.2]
  def change
    create_table :screenshots do |t|
      t.string :url
    end
  end
end
