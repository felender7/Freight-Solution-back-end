class AttendanceRecord < ApplicationRecord
  belongs_to :employee
  belongs_to :user, optional: true
end
