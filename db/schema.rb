# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_25_140739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "status_match_enum", ["pending", "approved", "rejected"]

  create_table "cat_matches", force: :cascade do |t|
    t.bigint "issuer_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "match_cat_id", null: false
    t.bigint "user_cat_id", null: false
    t.string "message", limit: 120, null: false
    t.enum "status", null: false, enum_type: "status_match_enum"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["issuer_id"], name: "index_cat_matches_on_issuer_id"
    t.index ["receiver_id"], name: "index_cat_matches_on_receiver_id"
    t.index ["user_cat_id", "match_cat_id", "status"], name: "idx_cat_matches_all_columns"
  end

  create_table "cats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", limit: 30, null: false
    t.string "race", null: false
    t.string "sex", null: false
    t.integer "age_in_months", null: false
    t.text "image_urls", default: [], array: true
    t.string "description", limit: 200, null: false
    t.boolean "has_matched", default: false, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_cats_on_name"
    t.index ["user_id"], name: "index_cats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "email", limit: 255, null: false
    t.string "password", limit: 100
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name", "email"], name: "user_index_1"
  end

  add_foreign_key "cat_matches", "users", column: "issuer_id"
  add_foreign_key "cat_matches", "users", column: "receiver_id"
  add_foreign_key "cats", "users"
end
