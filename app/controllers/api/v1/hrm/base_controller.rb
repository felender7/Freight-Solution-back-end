class Api::V1::Hrm::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  before_action :ensure_employee_record

  private

  def ensure_employee_record
    return if current_user.role == 'admin' || current_user.role == 'hr_manager'
    
    @current_employee = current_user.employee
    unless @current_employee
      render json: { error: "Employee record not found" }, status: :forbidden
    end
  end

  def current_employee
    @current_employee || current_user.employee
  end
end
