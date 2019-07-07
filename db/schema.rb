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

ActiveRecord::Schema.define(version: 2019_07_06_211932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inventories", force: :cascade do |t|
    t.bigint "survivor_id"
    t.integer "water", default: 0
    t.integer "food", default: 0
    t.integer "medication", default: 0
    t.integer "ammunition", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cached_points", default: 0
    t.index ["survivor_id"], name: "index_inventories_on_survivor_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "reporter_id"
    t.bigint "reported_id"
    t.string "reporter_type"
    t.string "reported_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reported_id"], name: "index_reports_on_reported_id"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "survivors", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latitude", precision: 10, scale: 6, default: "0.0", null: false
    t.decimal "longitude", precision: 10, scale: 6, default: "0.0", null: false
    t.integer "cached_votes_up", default: 0
    t.integer "times_reported", default: 0
  end

  add_foreign_key "inventories", "survivors"
  add_foreign_key "reports", "survivors", column: "reported_id", on_delete: :cascade
  add_foreign_key "reports", "survivors", column: "reporter_id", on_delete: :cascade
end
