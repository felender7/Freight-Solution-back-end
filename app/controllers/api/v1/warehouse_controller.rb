class Api::V1::WarehouseController < ApplicationController
  before_action :authenticate_request, except: [ :inventory, :transfers, :locations ]

  def inventory
    case request.method
    when "GET"
      index_inventory
    when "POST"
      create_inventory
    end
  end

  def item
    case request.method
    when "GET"
      show_item
    when "PUT"
      update_item
    when "DELETE"
      destroy_item
    end
  end

  def transfers
    case request.method
    when "GET"
      index_transfers
    when "POST"
      create_transfer
    end
  end

  def locations
    @locations = WarehouseLocation.all
    render json: @locations
  end

  private

  def index_inventory
    @inventory = InventoryRecord.includes(:inventory_item, :warehouse_location, :client).all
    render json: @inventory, include: [:inventory_item, :warehouse_location, :client]
  end

  def create_inventory
    @record = InventoryRecord.new(inventory_params)
    @record.user = current_user
    if @record.save
      render json: @record, status: :created
    else
      render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show_item
    @record = InventoryRecord.find(params[:id])
    render json: @record, include: [:inventory_item, :warehouse_location, :client]
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }, status: :not_found
  end

  def update_item
    @record = InventoryRecord.find(params[:id])
    if @record.update(inventory_params)
      render json: @record
    else
      render json: { errors: @record.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }, status: :not_found
  end

  def destroy_item
    @record = InventoryRecord.find(params[:id])
    @record.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }, status: :not_found
  end

  def index_transfers
    @transactions = WarehouseTransaction.includes(:inventory_item, :from_location, :to_location, :client).order(created_at: :desc)
    render json: @transactions, include: [:inventory_item, :from_location, :to_location, :client]
  end

  def create_transfer
    @transaction = WarehouseTransaction.new(transfer_params)
    @transaction.user = current_user
    @transaction.transaction_type ||= 'transfer'

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def inventory_params
    params.permit(:inventory_item_id, :warehouse_location_id, :client_id, :quantity, :batch_number, :expiry_date)
  end

  def transfer_params
    params.permit(:inventory_item_id, :from_location_id, :to_location_id, :client_id, :quantity, :transaction_type, :reference_number)
  end
end
