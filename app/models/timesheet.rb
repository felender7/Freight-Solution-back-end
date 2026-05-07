class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :approved_by, class_name: "User", optional: true
  belongs_to :task, optional: true
  belongs_to :user, optional: true

  enum :status, {
    draft: "draft",
    submitted: "submitted",
    approved: "approved",
    rejected: "rejected"
  }

  validates :date, presence: true
  validates :hours_worked, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
end
