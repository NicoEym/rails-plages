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

ActiveRecord::Schema.define(version: 2020_07_07_234256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beaches", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "number_of_team_members"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.date "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_lifeguards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_lifeguards_on_team_id"
    t.index ["user_id"], name: "index_team_lifeguards_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "beach_id"
    t.bigint "calendar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beach_id"], name: "index_teams_on_beach_id"
    t.index ["calendar_id"], name: "index_teams_on_calendar_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobile"
    t.string "avatar_url"
    t.string "firstname"
    t.string "lastname"
    t.boolean "admin", default: false, null: false
    t.boolean "head"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "team_lifeguards", "teams"
  add_foreign_key "team_lifeguards", "users"
  add_foreign_key "teams", "beaches"
  add_foreign_key "teams", "calendars"
end
