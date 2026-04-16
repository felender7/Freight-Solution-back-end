class CreateActivityLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_logs do |t|
      t.references :actor, foreign_key: { to_table: :users }
      t.string :entity_type
      t.integer :entity_id
      t.string :action
      t.json :metadata
      t.timestamps
    end
  end
end
