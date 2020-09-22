# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_21_085438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.integer "year"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stata_fuels", id: :serial, force: :cascade do |t|
    t.decimal "odo"
    t.decimal "odo_delta"
    t.decimal "refueling"
    t.decimal "price_fuel"
    t.string "fuel_station"
    t.string "fuel_type"
    t.integer "bike_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bike_id"], name: "index_stata_fuels_on_bike_id"
  end

  create_table "stata_repairs", id: :serial, force: :cascade do |t|
    t.string "type"
    t.string "note"
    t.decimal "price"
    t.integer "bike_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bike_id"], name: "index_stata_repairs_on_bike_id"
  end

end
