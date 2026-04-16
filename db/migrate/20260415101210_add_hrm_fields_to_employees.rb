class AddHrmFieldsToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :address, :string
    add_column :employees, :city, :string
    add_column :employees, :state, :string
    add_column :employees, :country, :string
    add_column :employees, :zip_code, :string
    add_column :employees, :employee_code, :string
    add_reference :employees, :manager, null: true, foreign_key: { to_table: :employees }
    add_column :employees, :employment_status, :string
    add_column :employees, :education_background, :text
  end
end
