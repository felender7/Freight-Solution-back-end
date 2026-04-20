class Admin::ClientsController < Admin::BaseController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to admin_clients_path, notice: "Client was successfully onboarded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to admin_clients_path, notice: "Client profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    redirect_to admin_clients_path, notice: "Client records were successfully deleted."
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(
      :name, :email, :phone, :address, :status, :category,
      :registration_number, :vat_number, :kyc_status, :credit_score,
      :credit_limit, :payment_terms, :risk_category, :fx_exposure,
      :fica_compliant, :aml_checked, :bank_verified, :sanctions_screened,
      :registration_doc, :director_id_doc, :bank_confirmation_doc,
      :tax_compliance_doc, :proof_of_address_doc, trade_references_docs: []
    )
  end
end
