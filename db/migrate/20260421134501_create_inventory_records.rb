class CreateInventoryRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :inventory_records do |t|
      t.references :inventory_item, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :warehouse_location, null: false, foreign_key: true
      t.references :pallet, null: false, foreign_key: true
      t.integer :quantity
      t.string :batch_number
      t.date :expiry_date

      t.timestamps
    end
  end
end
