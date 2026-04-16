class TrainingCourse < ApplicationRecord
  has_many :enrollments
  has_many :employees, through: :enrollments
end
