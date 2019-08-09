class AddUrlsToRatingSystems < ActiveRecord::Migration[5.2]
  def change
    add_column :rating_systems, :urls, :string
  end
end
