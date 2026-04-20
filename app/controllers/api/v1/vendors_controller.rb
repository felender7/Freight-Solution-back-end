class Api::V1::VendorsController < ApplicationController
  before_action :authenticate_request
  before_action :set_vendor, only: [:show, :update, :destroy]

  def index
    @vendors = Vendor.all
    render json: @vendors
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
    params.require(:vendor).permit(:name, :email, :phone, :address, :bank_reference, :status)
  end
end
