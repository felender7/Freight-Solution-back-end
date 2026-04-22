class CreatePallets < ActiveRecord::Migration[8.1]
  def change
    create_table :pallets do |t|
      t.string :pallet_number, null: false
      t.references :client, null: false, foreign_key: true
      t.references :warehouse_location, null: true, foreign_key: true
      t.string :status, default: 'active'
      t.decimal :weight, precision: 15, scale: 2, default: 0.0
      t.decimal :volume, precision: 15, scale: 2, default: 0.0

      t.timestamps
    end
    add_index :pallets, :pallet_number, unique: true
    add_index :pallets, :status
  end
end
