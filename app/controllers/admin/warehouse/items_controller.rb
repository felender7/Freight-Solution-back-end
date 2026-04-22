class Admin::Warehouse::ItemsController < Admin::BaseController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = InventoryItem.all.order(:name)
  end

  def show
  end

  def new
    @item = InventoryItem.new
  end

  def create
    @item = InventoryItem.new(item_params)
    if @item.save
      redirect_to admin_warehouse_items_path, notice: "SKU created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to admin_warehouse_items_path, notice: "SKU updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_warehouse_items_path, notice: "SKU deleted."
  end

  private

  def set_item
    @item = InventoryItem.find(params[:id])
  end

  def item_params
    params.require(:inventory_item).permit(:name, :sku, :barcode, :description, :category, :unit_weight, :unit_volume, :reorder_level)
  end
end
