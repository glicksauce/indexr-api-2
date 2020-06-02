class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :last_access_token
      t.string :dbx_user_id, unique: true, index: true

      t.timestamps
    end
  end
end
