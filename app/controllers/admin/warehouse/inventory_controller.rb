class Admin::Warehouse::InventoryController < Admin::BaseController
  before_action :set_inventory_record, only: [:show, :edit, :update, :destroy]
  before_action :set_form_data, only: [:new, :edit, :create, :update]

  def index
    @inventory_records = InventoryRecord.includes(:inventory_item, :client, :warehouse_location).all
  end

  def show
  end

  def new
    @inventory_record = InventoryRecord.new
  end

  def create
    @inventory_record = InventoryRecord.new(inventory_params)
    if @inventory_record.save
      log_transaction('receiving', @inventory_record.quantity, nil, @inventory_record.warehouse_location)
      redirect_to admin_warehouse_inventory_index_path, notice: "Stock was successfully received and recorded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    old_qty = @inventory_record.quantity
    if @inventory_record.update(inventory_params)
      diff = @inventory_record.quantity - old_qty
      log_transaction('adjustment', diff.abs, nil, nil) if diff != 0
      redirect_to admin_warehouse_inventory_index_path, notice: "Inventory record was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory_record.destroy
    redirect_to admin_warehouse_inventory_index_path, notice: "Inventory record was successfully removed."
  end

  private

  def set_inventory_record
    @inventory_record = InventoryRecord.find(params[:id])
  end

  def set_form_data
    @items = InventoryItem.all.order(:name)
    @clients = Client.all.order(:name)
    @locations = WarehouseLocation.all.order(:name)
  end

  def log_transaction(type, qty, from, to)
    WarehouseTransaction.create!(
      transaction_type: type,
      inventory_item: @inventory_record.inventory_item,
      client: @inventory_record.client,
      from_location: from,
      to_location: to,
      quantity: qty,
      user: current_user
    )
  end

  def inventory_params
    params.require(:inventory_record).permit(:inventory_item_id, :client_id, :warehouse_location_id, :pallet_id, :quantity, :batch_number, :expiry_date)
  end
end
