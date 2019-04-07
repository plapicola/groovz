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

ActiveRecord::Schema.define(version: 2019_04_06_163913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.bigint "user_id"
    t.string "artist_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spotify_id"
    t.index ["user_id"], name: "index_artists_on_user_id"
  end

  create_table "parties", force: :cascade do |t|
    t.bigint "user_id"
    t.string "playlist_id"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_parties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.integer "expires_at"
    t.boolean "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "mode"
    t.float "acousticness"
    t.float "danceability"
    t.float "energy"
    t.float "valence"
    t.float "tempo"
    t.bigint "party_id"
    t.index ["party_id"], name: "index_users_on_party_id"
  end

  add_foreign_key "artists", "users"
  add_foreign_key "parties", "users"
  add_foreign_key "users", "parties"
end
