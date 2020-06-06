class CreateDropAndCreateNewAlbumTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :album_tags

    create_table :album_tags do |t|
      t.integer :album_id, foreign_key: true
      t.integer :tag_id, foreign_key: true

      t.timestamps
    end

  end
end
