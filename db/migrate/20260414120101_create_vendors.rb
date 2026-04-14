class CreateVendors < ActiveRecord::Migration[8.1]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.string :bank_reference
      t.string :status

      t.timestamps
    end
  end
end
