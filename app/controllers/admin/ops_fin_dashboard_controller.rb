class Admin::OpsFinDashboardController < Admin::BaseController
  def index
    # Operations Stats
    @vendors_count = Vendor.count
    @clients_count = Client.count
    @shipments_count = Shipment.count
    @recent_shipments = Shipment.order(created_at: :desc).limit(5)
    
    # Finance Stats
    @invoices_count = Invoice.count
    @total_revenue = Invoice.where(status: 'paid').sum(:amount) || 0
    @pending_revenue = Invoice.where(status: 'pending').sum(:amount) || 0
    @overdue_invoices = Invoice.where('due_date < ? AND status != ?', Date.today, 'paid').count
    @recent_invoices = Invoice.includes(:vendor).order(created_at: :desc).limit(5)
  end
end
