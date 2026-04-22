class Admin::Warehouse::BillingsController < Admin::BaseController
  def index
    @billings = StorageBilling.includes(:client).order(billing_date: :desc)
  end
end
