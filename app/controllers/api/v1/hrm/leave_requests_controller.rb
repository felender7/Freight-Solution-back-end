class Api::V1::Hrm::LeaveRequestsController < Api::V1::Hrm::BaseController
  def index
    @leave_requests = current_employee.leave_requests.order(start_date: :desc)
    render json: @leave_requests
  end

  def create
    @leave_request = current_employee.leave_requests.new(leave_request_params)
    @leave_request.status = "pending"

    if @leave_request.save
      render json: @leave_request, status: :created
    else
      render json: { errors: @leave_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @leave_request = current_employee.leave_requests.find(params[:id])
    render json: @leave_request
  end

  def destroy
    @leave_request = current_employee.leave_requests.find(params[:id])
    if @leave_request.status == "pending"
      @leave_request.destroy
      render json: { message: "Leave request cancelled" }
    else
      render json: { error: "Only pending requests can be cancelled" }, status: :unprocessable_entity
    end
  end

  private

  def leave_request_params
    params.require(:leave_request).permit(:leave_type, :start_date, :end_date, :reason)
  end
end
