class CreateShipments < ActiveRecord::Migration[8.1]
  def change
    create_table :shipments do |t|
      t.string :container_number
      t.string :booking_reference
      t.string :origin
      t.string :destination
      t.string :status
      t.date :ship_date
      t.date :estimated_arrival

      t.timestamps
    end
  end
end
