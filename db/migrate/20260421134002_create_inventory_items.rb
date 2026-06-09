class CreateInventoryItems < ActiveRecord::Migration[8.1]
  def change
    create_table :inventory_items do |t|
      t.string :name, null: false
      t.string :sku, null: false
      t.string :barcode
      t.text :description
      t.string :category
      t.decimal :unit_weight, precision: 15, scale: 2, default: 0.0
      t.decimal :unit_volume, precision: 15, scale: 2, default: 0.0
      t.integer :reorder_level, default: 0

      t.timestamps
    end
    add_index :inventory_items, :sku, unique: true
    add_index :inventory_items, :barcode, unique: true
    add_index :inventory_items, :category
  end
end
