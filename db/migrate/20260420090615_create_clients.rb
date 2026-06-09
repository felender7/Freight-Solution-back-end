class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.text :address
      t.string :status, default: 'active'
      t.string :category
      t.string :registration_number
      t.string :vat_number
      t.string :kyc_status, default: 'pending'
      t.integer :credit_score, default: 0
      t.decimal :credit_limit, precision: 15, scale: 2, default: 0.0
      t.string :payment_terms
      t.string :risk_category
      t.decimal :fx_exposure, precision: 15, scale: 2, default: 0.0
      t.boolean :fica_compliant, default: false
      t.boolean :aml_checked, default: false
      t.boolean :bank_verified, default: false
      t.boolean :sanctions_screened, default: false

      t.timestamps
    end

    add_index :clients, :email, unique: true
    add_index :clients, :category
    add_index :clients, :status
    add_index :clients, :kyc_status
  end
end
