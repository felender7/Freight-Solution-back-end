class Admin::DashboardController < Admin::BaseController
  def index
    @employees_count = Employee.count
    @vendors_count = Vendor.count
    @shipments_count = Shipment.count
    @invoices_count = Invoice.count
    @total_revenue = Invoice.where(status: "paid").sum(:amount) || 0
    @pending_invoices = Invoice.where(status: "pending").count
    @recent_shipments = Shipment.order(created_at: :desc).limit(5)
    @recent_invoices = Invoice.order(created_at: :desc).limit(5)
  end
end
