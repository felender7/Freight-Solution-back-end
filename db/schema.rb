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

ActiveRecord::Schema[8.1].define(version: 2026_04_15_101210) do
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
    t.string "bank_reference"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "status"
    t.datetime "updated_at", null: false
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
  add_foreign_key "leave_requests", "employees"
  add_foreign_key "leave_requests", "users", column: "approved_by_id"
  add_foreign_key "performance_reviews", "employees"
  add_foreign_key "performance_reviews", "users", column: "reviewer_id"
  add_foreign_key "tasks", "employees"
  add_foreign_key "tasks", "users", column: "assigned_by_id"
  add_foreign_key "timesheets", "employees"
  add_foreign_key "timesheets", "tasks"
  add_foreign_key "timesheets", "users", column: "approved_by_id"
end
