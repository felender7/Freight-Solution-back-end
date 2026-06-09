class Admin::Warehouse::TransactionsController < Admin::BaseController
  def index
    @transactions = WarehouseTransaction.includes(:inventory_item, :client, :from_location, :to_location, :user).order(created_at: :desc)
  end
end
