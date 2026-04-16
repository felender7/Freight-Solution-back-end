class CreateTrainingCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :training_courses do |t|
      t.string :title
      t.text :description
      t.string :category
      t.integer :duration_hours
      t.string :certificate_url
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end
