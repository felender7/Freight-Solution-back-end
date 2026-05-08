class Api::V1::Hrm::TimesheetsController < Api::V1::Hrm::BaseController
  def index
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @timesheets = Timesheet.all.order(date: :desc)
    elsif current_employee
      @timesheets = current_employee.timesheets.order(date: :desc)
    else
      @timesheets = []
    end
    render json: @timesheets
  end

  def show
    @timesheet = Timesheet.find(params[:id])
    render json: @timesheet
  end

  def create
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @timesheet = current_employee.timesheets.new(timesheet_params)
    @timesheet.user = current_user
    @timesheet.status = "draft"

    if @timesheet.save
      render json: @timesheet, status: :created
    else
      render json: { errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @timesheet = current_employee.timesheets.find(params[:id])
    if @timesheet.status == "draft" || @timesheet.status == "rejected"
      if @timesheet.update(timesheet_params)
        render json: @timesheet
      else
        render json: { errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Only draft or rejected timesheets can be edited" }, status: :unprocessable_entity
    end
  end

  def submit
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @timesheet = current_employee.timesheets.find(params[:id])
    @timesheet.update(status: "submitted")
    render json: @timesheet
  end

  def approve
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @timesheet = Timesheet.find(params[:id])
      @timesheet.update(status: "approved", approved_by: current_user)
      render json: @timesheet
    else
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def reject
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @timesheet = Timesheet.find(params[:id])
      @timesheet.update(status: "rejected")
      render json: @timesheet
    else
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def destroy
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @timesheet = current_employee.timesheets.find(params[:id])
    if @timesheet.status == "draft"
      @timesheet.destroy
      render json: { message: "Timesheet deleted" }
    else
      render json: { error: "Only draft timesheets can be deleted" }, status: :unprocessable_entity
    end
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:date, :hours_worked, :description, :task_id)
  end
end
