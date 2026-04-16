class CreatePerformanceReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :performance_reviews do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :reviewer, foreign_key: { to_table: :users }
      t.integer :rating
      t.text :feedback
      t.string :review_cycle
      t.date :review_date
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
