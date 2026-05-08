class Api::V1::ClientsController < ApplicationController
  before_action :authenticate_request
  before_action :set_client, only: [ :show, :update, :destroy ]

  def index
    @clients = Client.all

    @clients = @clients.where("name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    @clients = @clients.where(category: params[:category]) if params[:category].present?
    @clients = @clients.where(status: params[:status]) if params[:status].present?

    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 20

    total = @clients.count
    total_pages = (total.to_f / per_page).ceil
    @clients = @clients.offset((page - 1) * per_page).limit(per_page)

    render json: {
      clients: @clients,
      total: total,
      page: page,
      per_page: per_page,
      total_pages: total_pages
    }
  end

  def show
    render json: @client
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    if @client.save
      render json: @client, status: :created
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    head :no_content
  end

  private

  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Client not found" }, status: :not_found
  end

  def client_params
    params.require(:client).permit(
      :name, :email, :phone, :address, :status, :category,
      :registration_number, :vat_number, :kyc_status, :credit_score,
      :credit_limit, :payment_terms, :risk_category, :fx_exposure,
      :fica_compliant, :aml_checked, :bank_verified, :sanctions_screened
    )
  end
end
