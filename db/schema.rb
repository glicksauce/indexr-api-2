# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_01_025519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_tags", id: false, force: :cascade do |t|
    t.integer "album_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_tags_on_album_id"
    t.index ["tag_id"], name: "index_album_tags_on_tag_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "dbx_image_id"
    t.string "image_name"
    t.string "image_path"
    t.string "dbx_user_id"
    t.date "client_modified_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_string"
    t.string "dbx_user_id"
    t.string "tag_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "last_access_token"
    t.string "dbx_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dbx_user_id"], name: "index_users_on_dbx_user_id"
  end

end
