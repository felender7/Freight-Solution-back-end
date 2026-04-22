class CreateWarehouseLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :warehouse_locations do |t|
      t.string :name, null: false
      t.string :zone
      t.string :location_type
      t.decimal :capacity_volume, precision: 15, scale: 2, default: 0.0
      t.decimal :current_volume, precision: 15, scale: 2, default: 0.0
      t.decimal :capacity_weight, precision: 15, scale: 2, default: 0.0
      t.decimal :current_weight, precision: 15, scale: 2, default: 0.0
      t.boolean :is_full, default: false

      t.timestamps
    end
    add_index :warehouse_locations, :name, unique: true
    add_index :warehouse_locations, :zone
    add_index :warehouse_locations, :location_type
  end
end
