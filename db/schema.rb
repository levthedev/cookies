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

ActiveRecord::Schema.define(version: 20160428163239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.integer  "calories"
    t.integer  "price"
    t.integer  "diet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "substitutions", id: false, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "ingredient_sub_id"
  end

  add_index "substitutions", ["ingredient_id", "ingredient_sub_id"], name: "index_substitutions_on_ingredient_id_and_ingredient_sub_id", unique: true, using: :btree
  add_index "substitutions", ["ingredient_sub_id", "ingredient_id"], name: "index_substitutions_on_ingredient_sub_id_and_ingredient_id", unique: true, using: :btree

end
