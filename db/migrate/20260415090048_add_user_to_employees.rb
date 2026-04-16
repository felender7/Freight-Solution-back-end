class AddUserToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_reference :employees, :user, foreign_key: true, null: true
  end
end
