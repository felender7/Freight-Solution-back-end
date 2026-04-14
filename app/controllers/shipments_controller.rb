class ShipmentsController < ApplicationController
  before_action :set_shipment, only: %i[ show edit update destroy ]

  # GET /shipments
  def index
    @shipments = Shipment.all
  end

  # GET /shipments/1
  def show
  end

  # GET /shipments/new
  def new
    @shipment = Shipment.new
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments
  def create
    @shipment = Shipment.new(shipment_params)

    if @shipment.save
      redirect_to @shipment, notice: "Shipment was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /shipments/1
  def update
    if @shipment.update(shipment_params)
      redirect_to @shipment, notice: "Shipment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /shipments/1
  def destroy
    @shipment.destroy!
    redirect_to shipments_path, notice: "Shipment was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def shipment_params
      params.expect(shipment: [ :container_number, :booking_reference, :origin, :destination, :status, :ship_date, :estimated_arrival ])
    end
end
