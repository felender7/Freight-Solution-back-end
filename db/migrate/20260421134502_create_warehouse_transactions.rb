class CreateWarehouseTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :warehouse_transactions do |t|
      t.string :transaction_type
      t.references :inventory_item, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.integer :from_location_id
      t.integer :to_location_id
      t.integer :quantity
      t.string :reference_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
