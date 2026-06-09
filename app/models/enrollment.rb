class Enrollment < ApplicationRecord
  belongs_to :employee
  belongs_to :training_course
  belongs_to :user, optional: true
end
