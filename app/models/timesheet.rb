class Timesheet < ApplicationRecord
  belongs_to :employee
  belongs_to :approved_by, class_name: "User", optional: true
  belongs_to :task, optional: true
end
