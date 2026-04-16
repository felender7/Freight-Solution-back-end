class Enrollment < ApplicationRecord
  belongs_to :employee
  belongs_to :training_course
end
