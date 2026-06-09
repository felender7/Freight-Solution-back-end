class AddUserToLeaveAndTimesheets < ActiveRecord::Migration[8.1]
  def change
    add_reference :leave_requests, :user, null: true, foreign_key: true
    add_reference :timesheets, :user, null: true, foreign_key: true
  end
end
