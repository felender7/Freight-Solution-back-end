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
    @shipments = Shipment.all.order(created_at: :desc)
    render json: @shipments
  end

  def create_booking
    @shipment = Shipment.new(shipment_params)
    @shipment.user = current_user
    @shipment.booking_reference ||= "BK-#{Time.now.to_i}"
    @shipment.status ||= "pending"

    if @shipment.save
      render json: @shipment, status: :created
    else
      render json: { errors: @shipment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show_booking
    @shipment = Shipment.find(params[:id])
    render json: @shipment
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Booking not found" }, status: :not_found
  end

  def update_booking
    @shipment = Shipment.find(params[:id])
    if @shipment.update(shipment_params)
      render json: @shipment
    else
      render json: { errors: @shipment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Booking not found" }, status: :not_found
  end

  def destroy_booking
    @shipment = Shipment.find(params[:id])
    @shipment.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Booking not found" }, status: :not_found
  end

  def shipment_params
    params.permit(:booking_reference, :origin, :destination, :status, :container_number, :ship_date, :estimated_arrival)
  end
end
