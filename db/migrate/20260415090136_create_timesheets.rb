class CreateTimesheets < ActiveRecord::Migration[8.1]
  def change
    create_table :timesheets do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :approved_by, foreign_key: { to_table: :users }
      t.references :task, foreign_key: true
      t.date :date
      t.decimal :hours_worked
      t.text :description
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
