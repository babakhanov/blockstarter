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

ActiveRecord::Schema.define(version: 20160312145724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string   "name"
    t.string   "issuer"
    t.string   "description"
    t.string   "picture"
    t.string   "company_name"
    t.string   "address"
    t.decimal  "profit_margin"
    t.integer  "amount"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.integer  "wif_id"
    t.boolean  "is_issued",     default: false, null: false
    t.integer  "fee"
    t.text     "tx_hex"
    t.string   "asset_id"
    t.text     "tx_ids",        default: [],                 array: true
    t.boolean  "is_published",  default: false, null: false
  end

  add_index "assets", ["user_id"], name: "index_assets_on_user_id", using: :btree
  add_index "assets", ["wif_id"], name: "index_assets_on_wif_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "company_name"
    t.string   "address"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wifs", force: :cascade do |t|
    t.string   "wif"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wifs", ["user_id"], name: "index_wifs_on_user_id", using: :btree

  add_foreign_key "assets", "users"
  add_foreign_key "assets", "wifs"
  add_foreign_key "wifs", "users"
end
