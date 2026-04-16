class CreateLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_requests do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :approved_by, foreign_key: { to_table: :users }
      t.string :leave_type
      t.date :start_date
      t.date :end_date
      t.text :reason
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
