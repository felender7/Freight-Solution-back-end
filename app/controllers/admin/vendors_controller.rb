class Admin::VendorsController < Admin::BaseController
  def index
    @vendors = Vendor.all.order(created_at: :desc)
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      redirect_to admin_vendors_path, notice: "Vendor was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update(vendor_params)
      redirect_to admin_vendors_path, notice: "Vendor was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy
    redirect_to admin_vendors_path, notice: "Vendor was successfully deleted."
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :email, :phone, :address, :bank_reference, :status)
  end
end
