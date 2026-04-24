class TrainingCourse < ApplicationRecord
  belongs_to :user, optional: true
  has_many :enrollments
  has_many :employees, through: :enrollments
end
