class Task < ApplicationRecord
  belongs_to :employee
  belongs_to :assigned_by, class_name: "User", optional: true
end
