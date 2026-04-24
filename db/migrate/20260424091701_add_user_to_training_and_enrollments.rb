class AddUserToTrainingAndEnrollments < ActiveRecord::Migration[8.1]
  def change
    add_reference :training_courses, :user, null: true, foreign_key: true
    add_reference :enrollments, :user, null: true, foreign_key: true
  end
end
