class User < ApplicationRecord
    self.primary_key = :dbx_user_id
    has_many :albums, foreign_key: :dbx_user_id
end
