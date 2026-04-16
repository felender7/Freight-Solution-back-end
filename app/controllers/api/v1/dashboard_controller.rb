class Api::V1::DashboardController < ApplicationController
  before_action :authenticate_request

  def stats
    render json: {
      employees: Employee.count,
      activeShipments: Shipment.where.not(status: ["delivered", "cancelled"]).count,
      revenue: Invoice.where(status: "paid").sum(:amount),
      vendors: Vendor.count
    }
  end
end
