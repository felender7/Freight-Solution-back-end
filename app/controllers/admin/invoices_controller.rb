class Admin::InvoicesController < Admin::BaseController
  def index
    @invoices = Invoice.all.order(created_at: :desc)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
    @vendors = Vendor.all
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to admin_invoices_path, notice: "Invoice was successfully created."
    else
      @vendors = Vendor.all
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @vendors = Vendor.all
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to admin_invoices_path, notice: "Invoice was successfully updated."
    else
      @vendors = Vendor.all
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to admin_invoices_path, notice: "Invoice was successfully deleted."
  end

  private

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :vendor_id, :amount, :status, :due_date, :paid_date)
  end
end
