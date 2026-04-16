class Admin::TimesheetsController < ApplicationController
  before_action :set_timesheet, only: [ :show, :edit, :update, :destroy ]

  def index
    @timesheets = Timesheet.includes(:employee, :approved_by, :task).order(date: :desc)
  end

  def show
  end

  def new
    @timesheet = Timesheet.new
    @employees = Employee.all
    @users = User.all
    @tasks = Task.all
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    if @timesheet.save
      redirect_to admin_timesheets_path, notice: "Timesheet was successfully created."
    else
      @employees = Employee.all
      @users = User.all
      @tasks = Task.all
      render :new
    end
  end

  def edit
    @employees = Employee.all
    @users = User.all
    @tasks = Task.all
  end

  def update
    if @timesheet.update(timesheet_params)
      redirect_to admin_timesheets_path, notice: "Timesheet was successfully updated."
    else
      @employees = Employee.all
      @users = User.all
      @tasks = Task.all
      render :edit
    end
  end

  def destroy
    @timesheet.destroy
    redirect_to admin_timesheets_path, notice: "Timesheet was successfully deleted."
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  def timesheet_params
    params.require(:timesheet).permit(:employee_id, :approved_by_id, :task_id, :date, :hours_worked, :description, :status)
  end
end
