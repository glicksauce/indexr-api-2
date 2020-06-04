class AddIndextoUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :dbx_user_id
    add_index :users, :dbx_user_id, unique: true
  end
end
