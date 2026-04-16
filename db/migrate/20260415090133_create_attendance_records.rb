class CreateAttendanceRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :attendance_records do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :clock_in
      t.datetime :clock_out
      t.date :date
      t.string :status, default: 'present'
      t.string :ip_address
      t.timestamps
    end
  end
end
