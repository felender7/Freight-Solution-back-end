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
    params.require(:vendor).permit(
      :name, :email, :phone, :address, :bank_reference, :status,
      :category, :registration_number, :vat_number, :kyc_status, :risk_score,
      :fica_compliant, :aml_checked, :sanctions_screened, :bank_verified,
      :beneficial_ownership_declared, :contract_start_date, :contract_end_date,
      :sla_details, :rate_card_details, :penalty_clauses,
      :company_registration_doc, :tax_clearance_doc, :insurance_certificate_doc,
      :bank_confirmation_letter_doc, :bbbee_certificate_doc, contracts: []
    )
  end
end
