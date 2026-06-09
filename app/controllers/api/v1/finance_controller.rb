class Api::V1::FinanceController < ApplicationController
  before_action :authenticate_request

  def stats
    total_revenue = LedgerEntry.where(entry_type: 'credit', account_type: 'revenue').sum(:amount)
    total_payable = Invoice.where(status: 'pending').sum(:amount) # Assuming pending invoices are payable
    total_receivable = LedgerEntry.where(entry_type: 'debit', account_type: 'asset').sum(:amount) # Simplified
    pending_invoices = Invoice.where(status: 'pending').count

    render json: {
      total_revenue: total_revenue,
      accounts_payable: total_payable,
      accounts_receivable: total_receivable,
      pending_invoices_count: pending_invoices
    }
  end

  def ledger
    @entries = LedgerEntry.all.order(created_at: :desc)
    render json: @entries
  end
end
