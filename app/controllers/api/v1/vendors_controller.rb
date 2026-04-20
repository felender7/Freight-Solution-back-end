class Api::V1::VendorsController < ApplicationController
  before_action :authenticate_request, except: [ :index ]
  before_action :set_vendor, only: [ :show, :update, :destroy ]

  def stats
    total = Vendor.count
    active = Vendor.where(status: "active").count
    pending = Vendor.where(kyc_status: "pending").count

    avg_risk = Vendor.average(:risk_score).to_f.round(1)
    active_contracts = Vendor.where("contract_end_date >= ?", Date.today).count

    render json: {
      total: total,
      active: active,
      pending: pending,
      avg_performance: avg_risk,
      active_contracts: active_contracts
    }
  end

  def index
    @vendors = Vendor.all

    @vendors = @vendors.search_by(params[:search]) if params[:search].present?
    @vendors = @vendors.filter_by_category(params[:category]) if params[:category].present?
    @vendors = @vendors.filter_by_status(params[:status]) if params[:status].present?
    @vendors = @vendors.filter_by_kyc_status(params[:kyc_status]) if params[:kyc_status].present?

    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 20

    total = @vendors.count
    total_pages = (total.to_f / per_page).ceil
    @vendors = @vendors.offset((page - 1) * per_page).limit(per_page)

    render json: {
      vendors: @vendors,
      total: total,
      page: page,
      per_page: per_page,
      total_pages: total_pages
    }
  end

  def show
    render json: @vendor
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      render json: @vendor, status: :created
    else
      render json: { errors: @vendor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @vendor.update(vendor_params)
      render json: @vendor
    else
      render json: { errors: @vendor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @vendor.destroy
    head :no_content
  end

  private

  def set_vendor
    @vendor = Vendor.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Vendor not found" }, status: :not_found
  end

  def vendor_params
    params.require(:vendor).permit(
      :name, :email, :phone, :address, :bank_reference, :status,
      :category, :registration_number, :vat_number, :kyc_status,
      :risk_score, :fica_compliant, :aml_checked, :sanctions_screened,
      :bank_verified, :beneficial_ownership_declared,
      :contract_start_date, :contract_end_date,
      :sla_details, :rate_card_details, :penalty_clauses
    )
  end
end
