class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.integer :vendor_id
      t.decimal :amount
      t.string :status
      t.date :due_date
      t.date :paid_date

      t.timestamps
    end
  end
end
