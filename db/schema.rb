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

ActiveRecord::Schema.define(version: 20170814181248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alternatives", force: :cascade do |t|
    t.string "name"
    t.float "weight"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_alternatives_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_id"], name: "index_categories_on_tree_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "name"
    t.bigint "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_children_on_node_id"
  end

  create_table "clouds", force: :cascade do |t|
    t.integer "vm"
    t.integer "cpu"
    t.integer "ram"
    t.integer "storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string "name"
    t.float "weight"
    t.integer "hight"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_nodes_on_category_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.string "op1"
    t.string "op2"
    t.string "op3"
    t.string "op4"
    t.string "op5"
    t.string "op6"
    t.string "op7"
    t.string "op8"
    t.string "op9"
    t.string "op10"
    t.string "op11"
    t.string "op12"
    t.string "op13"
    t.string "op14"
    t.string "op15"
    t.string "op16"
    t.string "op17"
    t.string "op18"
    t.string "op19"
    t.string "op20"
    t.string "op21"
    t.string "op22"
    t.string "op23"
    t.string "op24"
    t.string "op25"
    t.integer "value1"
    t.integer "value2"
    t.integer "value3"
    t.integer "value4"
    t.integer "value5"
    t.integer "value6"
    t.integer "value7"
    t.integer "value8"
    t.integer "value9"
    t.integer "value10"
    t.integer "value11"
    t.integer "value12"
    t.integer "value13"
    t.integer "value14"
    t.integer "value15"
    t.integer "value16"
    t.integer "value17"
    t.integer "value18"
    t.integer "value19"
    t.integer "value20"
    t.integer "value21"
    t.integer "value22"
    t.integer "value23"
    t.integer "value24"
    t.integer "value25"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trees", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alternatives", "categories"
  add_foreign_key "categories", "trees"
  add_foreign_key "children", "nodes"
  add_foreign_key "nodes", "categories"
end
