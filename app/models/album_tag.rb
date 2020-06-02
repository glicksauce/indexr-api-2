class AlbumTag < ApplicationRecord
    belongs_to :album
    belongs_to :tag
end
