class ChangePalletIdNullOnInventoryRecords < ActiveRecord::Migration[8.1]
  def change
    change_column_null :inventory_records, :pallet_id, true
  end
end
