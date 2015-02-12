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

ActiveRecord::Schema.define(version: 20150212154910) do

  create_table "comments", force: :cascade do |t|
    t.string   "store_id"
    t.integer  "rate"
    t.text     "content"
    t.string   "guest_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.string   "store_id"
    t.string   "open_time"
    t.text     "introduction"
    t.string   "icon_url"
    t.string   "image_url_1"
    t.string   "image_url_2"
    t.string   "image_url_3"
    t.string   "web_address"
    t.integer  "total_rate"
    t.float    "average_rate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "major_types", force: :cascade do |t|
    t.string   "type_id"
    t.text     "type_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "minor_types", force: :cascade do |t|
    t.string   "type_id"
    t.text     "type_description"
    t.string   "major_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "store_id"
    t.string   "name"
    t.string   "phone_number"
    t.string   "city"
    t.text     "address"
    t.string   "major_type_id"
    t.string   "minor_type_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

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
