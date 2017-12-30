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

ActiveRecord::Schema.define(version: 20171210200646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "agents", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "avatar"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "email"
    t.integer  "down_payment"
    t.integer  "down_payment_type"
    t.decimal  "interest_rate"
    t.integer  "amort"
    t.integer  "agent_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "clients", ["agent_id"], name: "index_clients_on_agent_id", using: :btree

  create_table "listings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "address"
    t.integer  "beds"
    t.integer  "baths"
    t.integer  "parking"
    t.integer  "square_footage"
    t.integer  "year_built"
    t.date     "listing_date"
    t.integer  "asking_price"
    t.integer  "parking_price"
    t.integer  "condo_fees"
    t.integer  "property_tax"
    t.integer  "utility_cost"
    t.integer  "rent_amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "description"
    t.integer  "lot_size"
  end

  create_table "notes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "showing_id"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "notes", ["showing_id"], name: "index_notes_on_showing_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.uuid     "listing_id", null: false
    t.string   "url",        null: false
    t.string   "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pictures", ["listing_id"], name: "index_pictures_on_listing_id", using: :btree

  create_table "showings", force: :cascade do |t|
    t.uuid     "client_id",  null: false
    t.uuid     "listing_id", null: false
    t.date     "date"
    t.boolean  "compare"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "thumbup"
    t.boolean  "thumbdown"
  end

  add_index "showings", ["client_id"], name: "index_showings_on_client_id", using: :btree
  add_index "showings", ["listing_id"], name: "index_showings_on_listing_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "clients", "agents"
  add_foreign_key "notes", "showings"
  add_foreign_key "notes", "users"
end
