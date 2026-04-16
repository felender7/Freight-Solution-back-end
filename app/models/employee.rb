class Employee < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :manager, class_name: "Employee", optional: true
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"

  has_one_attached :profile_photo
  has_one_attached :contract
  has_one_attached :appointment_letter

  has_many :performance_reviews, dependent: :destroy
  has_many :attendance_records, dependent: :destroy
  has_many :leave_requests, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :timesheets, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :training_courses, through: :enrollments
  has_many :activity_logs, as: :entity

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :employee_code, uniqueness: true, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
