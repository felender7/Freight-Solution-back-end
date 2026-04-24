class Api::V1::Hrm::TimesheetsController < Api::V1::Hrm::BaseController
  def index
    @timesheets = current_employee.timesheets.order(date: :desc)
    render json: @timesheets
  end

  def create
    @timesheet = current_employee.timesheets.new(timesheet_params)
    @timesheet.status = "pending"
    @timesheet.user = current_user

    if @timesheet.save
      render json: @timesheet, status: :created
    else
      render json: { errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @timesheet = current_employee.timesheets.find(params[:id])
    render json: @timesheet
  end

  def destroy
    @timesheet = current_employee.timesheets.find(params[:id])
    if @timesheet.status == "pending"
      @timesheet.destroy
      render json: { message: "Timesheet deleted" }
    else
      render json: { error: "Only pending timesheets can be deleted" }, status: :unprocessable_entity
    end
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:date, :hours_worked, :description, :task_id)
  end
end
