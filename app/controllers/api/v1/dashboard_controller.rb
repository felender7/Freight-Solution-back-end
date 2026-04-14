class Api::V1::DashboardController < ApplicationController
  before_action :authenticate_request

  def stats
    render json: {
      employees: 45,
      activeShipments: 12,
      revenue: 125000,
      vendors: 28
    }
  end
end
