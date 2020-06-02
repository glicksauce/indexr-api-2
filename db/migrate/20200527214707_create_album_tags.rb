class CreateAlbumTags < ActiveRecord::Migration[5.2]
  def change
    create_table :album_tags, :id => false do |t|
      t.integer :image_id, foreign_key: true
      t.integer :tag_id, foreign_key: true

      t.timestamps
    end
    add_index :album_tags, :image_id
    add_index :album_tags, :tag_id
  end
end
