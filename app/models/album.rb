class Album < ApplicationRecord
    belongs_to :user, foreign_key: :dbx_user_id
    has_many :album_tags
    has_many :tags, through: :album_tags
end
