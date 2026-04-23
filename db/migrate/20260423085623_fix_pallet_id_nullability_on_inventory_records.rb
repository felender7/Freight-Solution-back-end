class FixPalletIdNullabilityOnInventoryRecords < ActiveRecord::Migration[8.1]
  def change
    change_column :inventory_records, :pallet_id, :bigint, null: true
  end
end
