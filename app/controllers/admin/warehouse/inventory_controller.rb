class Admin::Warehouse::InventoryController < Admin::BaseController
  def index
    @inventory_records = InventoryRecord.includes(:inventory_item, :client, :warehouse_location).all
  end

  def new
    @inventory_record = InventoryRecord.new
    @items = InventoryItem.all
    @clients = Client.all
    @locations = WarehouseLocation.where(is_full: false)
  end

  def create
    @inventory_record = InventoryRecord.new(inventory_params)
    if @inventory_record.save
      # Log transaction
      WarehouseTransaction.create!(
        transaction_type: 'receiving',
        inventory_item: @inventory_record.inventory_item,
        client: @inventory_record.client,
        to_location: @inventory_record.warehouse_location,
        quantity: @inventory_record.quantity,
        user: current_user
      )
      redirect_to admin_warehouse_inventory_index_path, notice: "Stock received successfully."
    else
      @items = InventoryItem.all
      @clients = Client.all
      @locations = WarehouseLocation.where(is_full: false)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inventory_params
    params.require(:inventory_record).permit(:inventory_item_id, :client_id, :warehouse_location_id, :pallet_id, :quantity, :batch_number, :expiry_date)
  end
end
