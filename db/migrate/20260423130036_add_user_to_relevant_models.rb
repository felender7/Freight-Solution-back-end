class AddUserToRelevantModels < ActiveRecord::Migration[8.1]
  def change
    add_reference :clients, :user, foreign_key: true, null: true
    add_reference :vendors, :user, foreign_key: true, null: true
    add_reference :shipments, :user, foreign_key: true, null: true
    add_reference :warehouse_locations, :user, foreign_key: true, null: true
    add_reference :inventory_items, :user, foreign_key: true, null: true
    add_reference :storage_billings, :user, foreign_key: true, null: true
    add_reference :inventory_records, :user, foreign_key: true, null: true
  end
end
