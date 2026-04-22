class CreateStorageBillings < ActiveRecord::Migration[8.1]
  def change
    create_table :storage_billings do |t|
      t.references :client, null: false, foreign_key: true
      t.date :billing_date, null: false
      t.integer :total_pallets, default: 0
      t.decimal :total_volume, precision: 15, scale: 2, default: 0.0
      t.decimal :daily_rate, precision: 15, scale: 2, default: 0.0
      t.decimal :amount, precision: 15, scale: 2, default: 0.0
      t.string :status, default: 'pending'

      t.timestamps
    end
    add_index :storage_billings, :billing_date
    add_index :storage_billings, :status
  end
end
