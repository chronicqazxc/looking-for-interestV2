# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150216024038) do

  create_table "comments", force: :cascade do |t|
    t.integer  "rate"
    t.text     "content"
    t.string   "guest_name"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["store_id"], name: "index_comments_on_store_id"

  create_table "details", force: :cascade do |t|
    t.string   "open_time"
    t.text     "introduction"
    t.string   "icon_url"
    t.string   "image_url_1"
    t.string   "image_url_2"
    t.string   "image_url_3"
    t.string   "web_address"
    t.integer  "total_rate"
    t.float    "average_rate"
    t.string   "other_info_1"
    t.string   "other_info_2"
    t.string   "other_info_3"
    t.string   "other_info_4"
    t.string   "other_info_5"
    t.integer  "store_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "details", ["store_id"], name: "index_details_on_store_id"

  create_table "major_types", force: :cascade do |t|
    t.text     "type_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "minor_types", force: :cascade do |t|
    t.text     "type_description"
    t.integer  "major_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "minor_types", ["major_type_id"], name: "index_minor_types_on_major_type_id"

  create_table "parse_jsons", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "major_type_id"
    t.integer  "minor_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "parse_jsons", ["major_type_id"], name: "index_parse_jsons_on_major_type_id"
  add_index "parse_jsons", ["minor_type_id"], name: "index_parse_jsons_on_minor_type_id"

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "city"
    t.text     "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "major_type_id"
    t.integer  "minor_type_id"
    t.integer  "parse_json_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "stores", ["major_type_id"], name: "index_stores_on_major_type_id"
  add_index "stores", ["minor_type_id"], name: "index_stores_on_minor_type_id"
  add_index "stores", ["parse_json_id"], name: "index_stores_on_parse_json_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "session_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["name"], name: "index_users_on_name"

end
