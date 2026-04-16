class Api::V1::Hrm::BaseController < ApplicationController
  before_action :authenticate_request
  before_action :ensure_employee_record

  private

  def ensure_employee_record
    @current_employee = current_user.employee
    unless @current_employee
      render json: { error: "Employee record not found" }, status: :forbidden
    end
  end

  def current_employee
    @current_employee
  end
end
