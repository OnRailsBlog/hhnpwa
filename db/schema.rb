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

ActiveRecord::Schema.define(version: 2020_12_30_153032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "by"
    t.bigint "hn_id"
    t.bigint "parent_id"
    t.text "text"
    t.boolean "dead"
    t.datetime "time"
    t.integer "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hn_id"], name: "index_comments_on_hn_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "hn_id"
    t.string "by"
    t.integer "hn_type"
    t.datetime "time"
    t.text "text"
    t.string "url"
    t.string "host"
    t.integer "score"
    t.string "title"
    t.integer "descendants"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hn_id"], name: "index_items_on_hn_id"
  end

  create_table "top_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.integer "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_top_items_on_item_id"
    t.index ["location"], name: "index_top_items_on_location"
  end

  add_foreign_key "top_items", "items"
end
