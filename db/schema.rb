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

ActiveRecord::Schema.define(version: 20150710190117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "organization_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "user_can_edit"
    t.boolean  "admin_contact"
    t.boolean  "account_contact"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_members", ["organization_id"], name: "index_organization_members_on_organization_id", using: :btree
  add_index "organization_members", ["user_id"], name: "index_organization_members_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "avatar"
    t.text     "tags",                     array: true
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.string   "maximum"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supply_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "supply_id"
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "supply_lists", ["supply_id"], name: "index_supply_lists_on_supply_id", using: :btree
  add_index "supply_lists", ["user_id"], name: "index_supply_lists_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "tags",                         array: true
    t.text     "about"
    t.string   "avatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "organization_members", "organizations"
  add_foreign_key "organization_members", "users"
  add_foreign_key "supply_lists", "supplies"
  add_foreign_key "supply_lists", "users"
end
