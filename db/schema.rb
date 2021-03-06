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

ActiveRecord::Schema.define(version: 20150903130938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "admins", ["user_id"], name: "index_admins_on_user_id", using: :btree

  create_table "agreements", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "agreement"
    t.string   "name"
    t.date     "valid_until"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "agreements", ["organization_id"], name: "index_agreements_on_organization_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "home_contents", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "admin_contact",   default: false
    t.boolean  "account_contact", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "organization_members", ["organization_id"], name: "index_organization_members_on_organization_id", using: :btree
  add_index "organization_members", ["user_id"], name: "index_organization_members_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "avatar"
    t.boolean  "signed_service_agreement", default: false
    t.boolean  "current",                  default: true
    t.date     "inactive_on"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal"
    t.text     "tags",                     default: [],                 array: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "sector"
    t.string   "twitter"
  end

  create_table "supplies", force: :cascade do |t|
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supply_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "supply_id"
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "organization_id"
  end

  add_index "supply_lists", ["organization_id"], name: "index_supply_lists_on_organization_id", using: :btree
  add_index "supply_lists", ["supply_id"], name: "index_supply_lists_on_supply_id", using: :btree
  add_index "supply_lists", ["user_id"], name: "index_supply_lists_on_user_id", using: :btree

  create_table "upload_logs", force: :cascade do |t|
    t.json     "log"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "upload_logs", ["key"], name: "index_upload_logs_on_key", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "account_type"
    t.date     "inactive_on"
    t.boolean  "current",                default: true
    t.text     "notes"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "signup_digest"
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "linked_in"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "admins", "users"
  add_foreign_key "agreements", "organizations"
  add_foreign_key "organization_members", "organizations"
  add_foreign_key "organization_members", "users"
  add_foreign_key "supply_lists", "organizations"
  add_foreign_key "supply_lists", "supplies"
  add_foreign_key "supply_lists", "users"
end
