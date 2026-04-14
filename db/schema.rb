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

ActiveRecord::Schema[8.1].define(version: 2026_04_14_120113) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "department"
    t.string "email"
    t.string "first_name"
    t.date "hire_date"
    t.string "last_name"
    t.string "phone"
    t.string "position"
    t.decimal "salary"
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.date "due_date"
    t.string "invoice_number"
    t.date "paid_date"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "booking_reference"
    t.string "container_number"
    t.datetime "created_at", null: false
    t.string "destination"
    t.date "estimated_arrival"
    t.string "origin"
    t.date "ship_date"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.boolean "must_update_password"
    t.string "password_digest"
    t.string "role"
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.text "address"
    t.string "bank_reference"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "status"
    t.datetime "updated_at", null: false
  end
end
