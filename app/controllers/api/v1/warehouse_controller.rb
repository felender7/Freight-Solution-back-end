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
    render json: [
      { id: 1, name: "Zone A", capacity: 1000, used: 650 },
      { id: 2, name: "Zone B", capacity: 800, used: 420 },
      { id: 3, name: "Zone C", capacity: 1200, used: 890 },
      { id: 4, name: "Zone D", capacity: 500, used: 180 }
    ]
  end

  private

  def index_inventory
    render json: [
      { id: 1, name: "Steel Pipes", sku: "SP-001", quantity: 150, location: "Zone A", category: "Raw Materials", last_updated: "2026-04-10" },
      { id: 2, name: "Copper Wire", sku: "CW-002", quantity: 45, location: "Zone B", category: "Raw Materials", last_updated: "2026-04-12" },
      { id: 3, name: "Industrial Motors", sku: "IM-003", quantity: 8, location: "Zone A", category: "Equipment", last_updated: "2026-04-08" },
      { id: 4, name: "Hydraulic Pumps", sku: "HP-004", quantity: 25, location: "Zone C", category: "Equipment", last_updated: "2026-04-11" }
    ]
  end

  def create_inventory
    item = {
      id: Time.now.to_i,
      name: params[:name],
      sku: params[:sku],
      quantity: params[:quantity] || 0,
      location: params[:location] || "Zone A",
      category: params[:category] || "General",
      last_updated: Date.today.to_s
    }
    render json: item, status: :created
  end

  def show_item
    render json: { id: 1, name: "Steel Pipes", sku: "SP-001", quantity: 150, location: "Zone A", category: "Raw Materials", last_updated: "2026-04-10" }
  end

  def update_item
    render json: { message: "Item updated" }
  end

  def destroy_item
    render json: { message: "Item deleted" }
  end

  def index_transfers
    render json: [
      { id: 101, item_name: "Steel Pipes", from_location: "Zone A", to_location: "Zone B", quantity: 50, status: "completed", date: "2026-04-10" },
      { id: 102, item_name: "Copper Wire", from_location: "Zone B", to_location: "Zone A", quantity: 20, status: "in_transit", date: "2026-04-13" },
      { id: 103, item_name: "Industrial Motors", from_location: "Zone A", to_location: "Zone C", quantity: 5, status: "pending", date: "2026-04-14" }
    ]
  end

  def create_transfer
    transfer = {
      id: Time.now.to_i,
      item_name: params[:item_name],
      from_location: params[:from_location],
      to_location: params[:to_location],
      quantity: params[:quantity] || 0,
      status: "pending",
      date: Date.today.to_s
    }
    render json: transfer, status: :created
  end
end
