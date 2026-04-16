class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :training_course, null: false, foreign_key: true
      t.integer :progress, default: 0
      t.boolean :is_completed, default: false
      t.date :completed_at
      t.string :certificate_url
      t.timestamps
    end
  end
end
