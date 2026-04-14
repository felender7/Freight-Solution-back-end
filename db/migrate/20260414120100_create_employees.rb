class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :position
      t.string :department
      t.decimal :salary
      t.date :hire_date

      t.timestamps
    end
  end
end
