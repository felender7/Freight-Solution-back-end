class Admin::LeaveRequestsController < ApplicationController
  before_action :set_leave_request, only: [ :show, :edit, :update, :destroy ]

  def index
    @leave_requests = LeaveRequest.includes(:employee, :approved_by).order(created_at: :desc)
  end

  def show
  end

  def new
    @leave_request = LeaveRequest.new
    @employees = Employee.all
    @users = User.all
  end

  def create
    @leave_request = LeaveRequest.new(leave_request_params)
    if @leave_request.save
      redirect_to admin_leave_requests_path, notice: "Leave request was successfully created."
    else
      @employees = Employee.all
      @users = User.all
      render :new
    end
  end

  def edit
    @employees = Employee.all
    @users = User.all
  end

  def update
    if @leave_request.update(leave_request_params)
      redirect_to admin_leave_requests_path, notice: "Leave request was successfully updated."
    else
      @employees = Employee.all
      @users = User.all
      render :edit
    end
  end

  def destroy
    @leave_request.destroy
    redirect_to admin_leave_requests_path, notice: "Leave request was successfully deleted."
  end

  private

  def set_leave_request
    @leave_request = LeaveRequest.find(params[:id])
  end

  def leave_request_params
    params.require(:leave_request).permit(:employee_id, :approved_by_id, :leave_type, :start_date, :end_date, :reason, :status)
  end
end
