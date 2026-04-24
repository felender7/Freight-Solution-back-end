class Admin::ShipmentsController < Admin::BaseController
  def index
    @shipments = Shipment.all.order(created_at: :desc)
  end

  def show
    @shipment = Shipment.find(params[:id])
  end

  def new
    @shipment = Shipment.new
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.user = current_user
    if @shipment.save
      redirect_to admin_shipments_path, notice: "Shipment was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @shipment = Shipment.find(params[:id])
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update(shipment_params)
      redirect_to admin_shipments_path, notice: "Shipment was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.destroy
    redirect_to admin_shipments_path, notice: "Shipment was successfully deleted."
  end

  private

  def shipment_params
    params.require(:shipment).permit(:container_number, :booking_reference, :origin, :destination, :status, :ship_date, :estimated_arrival)
  end
end
