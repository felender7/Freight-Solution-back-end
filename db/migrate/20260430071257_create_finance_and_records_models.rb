class CreateFinanceAndRecordsModels < ActiveRecord::Migration[8.1]
  def change
    create_table :ledger_entries do |t|
      t.decimal :amount, precision: 15, scale: 2, default: 0.0
      t.string :entry_type # debit, credit
      t.string :account_type # revenue, expense, asset, liability
      t.string :description
      t.string :reference_number
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :retention_policies do |t|
      t.string :title
      t.text :description
      t.integer :duration_months
      t.boolean :is_active, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :legal_holds do |t|
      t.string :title
      t.text :description
      t.string :entity_type
      t.integer :entity_id
      t.string :status, default: 'active'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
