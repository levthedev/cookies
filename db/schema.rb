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

ActiveRecord::Schema.define(version: 20160430204602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cookies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "parent_cookie_id"
  end

  create_table "cookies_ingredients", force: :cascade do |t|
    t.boolean  "allowed",       default: true, null: false
    t.integer  "ingredient_id"
    t.integer  "cookie_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "cookies_ingredients", ["cookie_id"], name: "index_cookies_ingredients_on_cookie_id", using: :btree
  add_index "cookies_ingredients", ["ingredient_id"], name: "index_cookies_ingredients_on_ingredient_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.integer  "calories"
    t.integer  "price"
    t.integer  "diet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_ingredients", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "store_ingredients", ["ingredient_id"], name: "index_store_ingredients_on_ingredient_id", using: :btree
  add_index "store_ingredients", ["store_id"], name: "index_store_ingredients_on_store_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "substitutions", id: false, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "substitution_id"
  end

  add_foreign_key "cookies_ingredients", "cookies"
  add_foreign_key "cookies_ingredients", "ingredients"
  add_foreign_key "store_ingredients", "ingredients"
  add_foreign_key "store_ingredients", "stores"
end
