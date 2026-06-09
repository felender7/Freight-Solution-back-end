class Api::V1::InvoicesController < ApplicationController
  before_action :authenticate_request
  before_action :set_invoice, only: [:show, :update, :destroy]

  def index
    @invoices = Invoice.all.order(created_at: :desc)
    render json: @invoices
  end

  def show
    render json: @invoice
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user
    if @invoice.save
      render json: @invoice, status: :created
    else
      render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @invoice.update(invoice_params)
      render json: @invoice
    else
      render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy
    head :no_content
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Invoice not found" }, status: :not_found
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :vendor_id, :amount, :status, :due_date, :paid_date)
  end
end
