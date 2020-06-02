class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :dbx_image_id, unique: true
      t.string :image_name
      t.string :image_path
      t.string :dbx_user_id
      t.date :client_modified_date

      t.timestamps
    end
  end
end
