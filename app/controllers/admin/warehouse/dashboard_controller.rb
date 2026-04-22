class Admin::Warehouse::DashboardController < Admin::BaseController
  def index
    @locations = WarehouseLocation.all
    @total_capacity_vol = @locations.sum(:capacity_volume)
    @current_vol = @locations.sum(:current_volume)
    @utilization = @total_capacity_vol > 0 ? (@current_vol / @total_capacity_vol * 100).round(2) : 0
    
    @recent_transactions = WarehouseTransaction.order(created_at: :desc).limit(10)
    @inventory_summary = InventoryItem.all.limit(10)
    
    @low_stock_items = InventoryItem.select("inventory_items.*, SUM(inventory_records.quantity) as total_qty")
                                    .joins(:inventory_records)
                                    .group("inventory_items.id")
                                    .having("SUM(inventory_records.quantity) < inventory_items.reorder_level")
  end
end
