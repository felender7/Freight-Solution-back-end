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

ActiveRecord::Schema[8.1].define(version: 2026_04_21_134502) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activity_logs", force: :cascade do |t|
    t.string "action"
    t.bigint "actor_id"
    t.datetime "created_at", null: false
    t.integer "entity_id"
    t.string "entity_type"
    t.json "metadata"
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_activity_logs_on_actor_id"
  end

  create_table "attendance_records", force: :cascade do |t|
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.datetime "created_at", null: false
    t.date "date"
    t.bigint "employee_id", null: false
    t.string "ip_address"
    t.string "status", default: "present"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["employee_id"], name: "index_attendance_records_on_employee_id"
    t.index ["user_id"], name: "index_attendance_records_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.text "address"
    t.boolean "aml_checked", default: false
    t.boolean "bank_verified", default: false
    t.string "category"
    t.datetime "created_at", null: false
    t.decimal "credit_limit", precision: 15, scale: 2, default: "0.0"
    t.integer "credit_score", default: 0
    t.string "email", null: false
    t.boolean "fica_compliant", default: false
    t.decimal "fx_exposure", precision: 15, scale: 2, default: "0.0"
    t.string "kyc_status", default: "pending"
    t.string "name", null: false
    t.string "payment_terms"
    t.string "phone"
    t.string "registration_number"
    t.string "risk_category"
    t.boolean "sanctions_screened", default: false
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.string "vat_number"
    t.index ["category"], name: "index_clients_on_category"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["kyc_status"], name: "index_clients_on_kyc_status"
    t.index ["status"], name: "index_clients_on_status"
  end

  create_table "employees", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "department"
    t.text "education_background"
    t.string "email"
    t.string "employee_code"
    t.string "employment_status"
    t.string "first_name"
    t.date "hire_date"
    t.string "last_name"
    t.bigint "manager_id"
    t.string "phone"
    t.string "position"
    t.decimal "salary"
    t.string "state"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "zip_code"
    t.index ["manager_id"], name: "index_employees_on_manager_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.string "certificate_url"
    t.date "completed_at"
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.boolean "is_completed", default: false
    t.integer "progress", default: 0
    t.bigint "training_course_id", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_enrollments_on_employee_id"
    t.index ["training_course_id"], name: "index_enrollments_on_training_course_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "barcode"
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.integer "reorder_level", default: 0
    t.string "sku", null: false
    t.decimal "unit_volume", precision: 15, scale: 2, default: "0.0"
    t.decimal "unit_weight", precision: 15, scale: 2, default: "0.0"
    t.datetime "updated_at", null: false
    t.index ["barcode"], name: "index_inventory_items_on_barcode", unique: true
    t.index ["category"], name: "index_inventory_items_on_category"
    t.index ["sku"], name: "index_inventory_items_on_sku", unique: true
  end

  create_table "inventory_records", force: :cascade do |t|
    t.string "batch_number"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.date "expiry_date"
    t.bigint "inventory_item_id", null: false
    t.bigint "pallet_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.bigint "warehouse_location_id", null: false
    t.index ["client_id"], name: "index_inventory_records_on_client_id"
    t.index ["inventory_item_id"], name: "index_inventory_records_on_inventory_item_id"
    t.index ["pallet_id"], name: "index_inventory_records_on_pallet_id"
    t.index ["warehouse_location_id"], name: "index_inventory_records_on_warehouse_location_id"
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

  create_table "leave_requests", force: :cascade do |t|
    t.bigint "approved_by_id"
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.date "end_date"
    t.string "leave_type"
    t.text "reason"
    t.date "start_date"
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.index ["approved_by_id"], name: "index_leave_requests_on_approved_by_id"
    t.index ["employee_id"], name: "index_leave_requests_on_employee_id"
  end

  create_table "pallets", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.string "pallet_number", null: false
    t.string "status", default: "active"
    t.datetime "updated_at", null: false
    t.decimal "volume", precision: 15, scale: 2, default: "0.0"
    t.bigint "warehouse_location_id"
    t.decimal "weight", precision: 15, scale: 2, default: "0.0"
    t.index ["client_id"], name: "index_pallets_on_client_id"
    t.index ["pallet_number"], name: "index_pallets_on_pallet_number", unique: true
    t.index ["status"], name: "index_pallets_on_status"
    t.index ["warehouse_location_id"], name: "index_pallets_on_warehouse_location_id"
  end

  create_table "performance_reviews", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.text "feedback"
    t.integer "rating"
    t.string "review_cycle"
    t.date "review_date"
    t.bigint "reviewer_id"
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_performance_reviews_on_employee_id"
    t.index ["reviewer_id"], name: "index_performance_reviews_on_reviewer_id"
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

  create_table "storage_billings", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.date "billing_date", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.decimal "daily_rate", precision: 15, scale: 2, default: "0.0"
    t.string "status", default: "pending"
    t.integer "total_pallets", default: 0
    t.decimal "total_volume", precision: 15, scale: 2, default: "0.0"
    t.datetime "updated_at", null: false
    t.index ["billing_date"], name: "index_storage_billings_on_billing_date"
    t.index ["client_id"], name: "index_storage_billings_on_client_id"
    t.index ["status"], name: "index_storage_billings_on_status"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "assigned_by_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "due_date"
    t.bigint "employee_id", null: false
    t.string "priority", default: "medium"
    t.string "status", default: "todo"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["assigned_by_id"], name: "index_tasks_on_assigned_by_id"
    t.index ["employee_id"], name: "index_tasks_on_employee_id"
  end

  create_table "timesheets", force: :cascade do |t|
    t.bigint "approved_by_id"
    t.datetime "created_at", null: false
    t.date "date"
    t.text "description"
    t.bigint "employee_id", null: false
    t.decimal "hours_worked"
    t.string "status", default: "pending"
    t.bigint "task_id"
    t.datetime "updated_at", null: false
    t.index ["approved_by_id"], name: "index_timesheets_on_approved_by_id"
    t.index ["employee_id"], name: "index_timesheets_on_employee_id"
    t.index ["task_id"], name: "index_timesheets_on_task_id"
  end

  create_table "training_courses", force: :cascade do |t|
    t.string "category"
    t.string "certificate_url"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "duration_hours"
    t.boolean "is_active", default: true
    t.string "title"
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
    t.boolean "aml_checked", default: false
    t.string "bank_reference"
    t.boolean "bank_verified", default: false
    t.boolean "beneficial_ownership_declared", default: false
    t.string "category"
    t.date "contract_end_date"
    t.date "contract_start_date"
    t.datetime "created_at", null: false
    t.string "email"
    t.boolean "fica_compliant", default: false
    t.string "kyc_status", default: "pending"
    t.string "name"
    t.text "penalty_clauses"
    t.string "phone"
    t.text "rate_card_details"
    t.string "registration_number"
    t.integer "risk_score", default: 0
    t.boolean "sanctions_screened", default: false
    t.text "sla_details"
    t.string "status"
    t.datetime "updated_at", null: false
    t.string "vat_number"
    t.index ["category"], name: "index_vendors_on_category"
    t.index ["kyc_status"], name: "index_vendors_on_kyc_status"
  end

  create_table "warehouse_locations", force: :cascade do |t|
    t.decimal "capacity_volume", precision: 15, scale: 2, default: "0.0"
    t.decimal "capacity_weight", precision: 15, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.decimal "current_volume", precision: 15, scale: 2, default: "0.0"
    t.decimal "current_weight", precision: 15, scale: 2, default: "0.0"
    t.boolean "is_full", default: false
    t.string "location_type"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.string "zone"
    t.index ["location_type"], name: "index_warehouse_locations_on_location_type"
    t.index ["name"], name: "index_warehouse_locations_on_name", unique: true
    t.index ["zone"], name: "index_warehouse_locations_on_zone"
  end

  create_table "warehouse_transactions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.integer "from_location_id"
    t.bigint "inventory_item_id", null: false
    t.integer "quantity"
    t.string "reference_number"
    t.integer "to_location_id"
    t.string "transaction_type"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["client_id"], name: "index_warehouse_transactions_on_client_id"
    t.index ["inventory_item_id"], name: "index_warehouse_transactions_on_inventory_item_id"
    t.index ["user_id"], name: "index_warehouse_transactions_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_logs", "users", column: "actor_id"
  add_foreign_key "attendance_records", "employees"
  add_foreign_key "attendance_records", "users"
  add_foreign_key "employees", "employees", column: "manager_id"
  add_foreign_key "employees", "users"
  add_foreign_key "enrollments", "employees"
  add_foreign_key "enrollments", "training_courses"
  add_foreign_key "inventory_records", "clients"
  add_foreign_key "inventory_records", "inventory_items"
  add_foreign_key "inventory_records", "pallets"
  add_foreign_key "inventory_records", "warehouse_locations"
  add_foreign_key "leave_requests", "employees"
  add_foreign_key "leave_requests", "users", column: "approved_by_id"
  add_foreign_key "pallets", "clients"
  add_foreign_key "pallets", "warehouse_locations"
  add_foreign_key "performance_reviews", "employees"
  add_foreign_key "performance_reviews", "users", column: "reviewer_id"
  add_foreign_key "storage_billings", "clients"
  add_foreign_key "tasks", "employees"
  add_foreign_key "tasks", "users", column: "assigned_by_id"
  add_foreign_key "timesheets", "employees"
  add_foreign_key "timesheets", "tasks"
  add_foreign_key "timesheets", "users", column: "approved_by_id"
  add_foreign_key "warehouse_transactions", "clients"
  add_foreign_key "warehouse_transactions", "inventory_items"
  add_foreign_key "warehouse_transactions", "users"
end
