class Admin::DashboardController < Admin::BaseController
  before_action :require_login
  helper_method :current_user
  layout "admin"

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

  private

  def require_login
    unless session[:user_id]
      redirect_to admin_login_path, alert: "Please log in first"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
