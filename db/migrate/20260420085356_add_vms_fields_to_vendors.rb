class AddVmsFieldsToVendors < ActiveRecord::Migration[8.1]
  def change
    add_column :vendors, :category, :string
    add_column :vendors, :registration_number, :string
    add_column :vendors, :vat_number, :string
    add_column :vendors, :kyc_status, :string, default: 'pending'
    add_column :vendors, :risk_score, :integer, default: 0
    add_column :vendors, :fica_compliant, :boolean, default: false
    add_column :vendors, :aml_checked, :boolean, default: false
    add_column :vendors, :sanctions_screened, :boolean, default: false
    add_column :vendors, :bank_verified, :boolean, default: false
    add_column :vendors, :beneficial_ownership_declared, :boolean, default: false
    add_column :vendors, :contract_start_date, :date
    add_column :vendors, :contract_end_date, :date
    add_column :vendors, :sla_details, :text
    add_column :vendors, :rate_card_details, :text
    add_column :vendors, :penalty_clauses, :text

    add_index :vendors, :category
    add_index :vendors, :kyc_status
  end
end
