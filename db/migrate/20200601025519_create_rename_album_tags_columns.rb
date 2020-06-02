class CreateRenameAlbumTagsColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :album_tags, :image_id, :album_id
  end
end
