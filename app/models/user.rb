class User < ApplicationRecord
  has_secure_password

  before_validation :set_default_values

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin hr_manager employee user] }

  has_one :employee

  has_many :created_tasks, class_name: "Task", foreign_key: "assigned_by_id"
  has_many :approved_attendance_records, class_name: "AttendanceRecord", foreign_key: "user_id"
  has_many :approved_leave_requests, class_name: "LeaveRequest", foreign_key: "approved_by_id"
  has_many :approved_timesheets, class_name: "Timesheet", foreign_key: "approved_by_id"
  has_many :activity_logs, foreign_key: :actor_id
  has_many :performance_reviews, foreign_key: :reviewer_id
  has_many :warehouse_transactions

  # New associations for ownership/creation tracking
  has_many :clients
  has_many :vendors
  has_many :shipments
  has_many :warehouse_locations
  has_many :inventory_items
  has_many :inventory_records
  has_many :storage_billings

  def set_default_values
    self.role ||= "user"
    self.must_update_password = true if must_update_password.nil?
  end

  def to_token_payload
    {
      sub: id,
      email: email,
      role: role
    }
  end
end
