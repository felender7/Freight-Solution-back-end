class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :assigned_by, foreign_key: { to_table: :users }
      t.string :title
      t.text :description
      t.string :priority, default: 'medium'
      t.string :status, default: 'todo'
      t.date :due_date
      t.timestamps
    end
  end
end
