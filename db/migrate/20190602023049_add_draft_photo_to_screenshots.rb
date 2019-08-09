class AddDraftPhotoToScreenshots < ActiveRecord::Migration[5.2]
  def change
    add_column :screenshots, :draft_photo, :string
  end
end
