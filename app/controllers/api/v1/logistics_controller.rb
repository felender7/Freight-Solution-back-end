class Api::V1::LogisticsController < ApplicationController
  before_action :authenticate_request, except: [ :bookings ]

  def bookings
    case request.method
    when "GET"
      index_bookings
    when "POST"
      create_booking
    end
  end

  def booking
    case request.method
    when "GET"
      show_booking
    when "PUT"
      update_booking
    when "DELETE"
      destroy_booking
    end
  end

  private

  def index_bookings
    render json: [
      { id: 1, booking_number: "BK-2026-001", vendor_name: "Fast Logistics", origin: "Johannesburg", destination: "Cape Town", container_type: "40ft", status: "pending", created_at: "2026-04-10" },
      { id: 2, booking_number: "BK-2026-002", vendor_name: "Cargo Masters", origin: "Durban", destination: "Pretoria", container_type: "20ft", status: "confirmed", created_at: "2026-04-11", quote_amount: 15000 },
      { id: 3, booking_number: "BK-2026-003", vendor_name: "Express Freight", origin: "Port Elizabeth", destination: "Johannesburg", container_type: "40ft", status: "in_transit", created_at: "2026-04-12", quote_amount: 22000 },
      { id: 4, booking_number: "BK-2026-004", vendor_name: "Global Shipping", origin: "Cape Town", destination: "Durban", container_type: "20ft", status: "delivered", created_at: "2026-04-08", quote_amount: 18500 }
    ]
  end

  def create_booking
    booking = {
      id: Time.now.to_i,
      booking_number: "BK-2026-#{rand(100..999)}",
      vendor_name: Vendor.find_by(id: params[:vendor_id])&.name || "Unknown",
      origin: params[:origin],
      destination: params[:destination],
      container_type: params[:container_type] || "20ft",
      status: "pending",
      created_at: Date.today.to_s
    }
    render json: booking, status: :created
  end

  def show_booking
    render json: { id: 1, booking_number: "BK-2026-001", vendor_name: "Fast Logistics", origin: "Johannesburg", destination: "Cape Town", container_type: "40ft", status: "pending", created_at: "2026-04-10", quote_amount: 12000 }
  end

  def update_booking
    render json: { message: "Booking updated" }
  end

  def destroy_booking
    render json: { message: "Booking deleted" }
  end
end
