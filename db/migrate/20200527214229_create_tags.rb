class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :tag_string
      t.string :dbx_user_id
      t.string :tag_type

      t.timestamps
    end
  end
end
