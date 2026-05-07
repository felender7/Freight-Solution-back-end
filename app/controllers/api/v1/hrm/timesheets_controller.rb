class Api::V1::Hrm::TimesheetsController < Api::V1::Hrm::BaseController
  def index
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @timesheets = Timesheet.where(status: [ "submitted", "approved", "rejected" ]).order(date: :desc)
    else
      @timesheets = current_employee.timesheets.order(date: :desc)
    end
    render json: @timesheets.as_json(include: { 
      employee: { only: [ :first_name, :last_name ] },
      task: { only: [ :title ] },
      approved_by: { only: [ :first_name, :last_name ] }
    })
  end

  def create
    @timesheet = current_employee.timesheets.new(timesheet_params)
    @timesheet.status = params[:submit] == "true" ? "submitted" : "draft"
    @timesheet.user = current_user

    if @timesheet.save
      render json: @timesheet, status: :created
    else
      render json: { errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @timesheet = current_employee.timesheets.find(params[:id])
    if @timesheet.draft?
      @timesheet.status = "submitted" if params[:submit] == "true"
      if @timesheet.update(timesheet_params)
        render json: @timesheet
      else
        render json: { errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Only draft timesheets can be edited" }, status: :unprocessable_entity
    end
  end

  def submit
    @timesheet = current_employee.timesheets.find(params[:id])
    if @timesheet.draft?
      if @timesheet.update(status: "submitted")
        render json: @timesheet
      else
        render json: { errors: @timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Only draft timesheets can be submitted" }, status: :unprocessable_entity
    end
  end

  def show
    @timesheet = Timesheet.find(params[:id])
    render json: @timesheet.as_json(include: { 
      employee: { only: [ :first_name, :last_name ] },
      task: { only: [ :title ] },
      approved_by: { only: [ :first_name, :last_name ] }
    })
  end

  def approve
    @timesheet = Timesheet.find(params[:id])
    if current_user.role == "admin" || current_user.role == "hr_manager"
      if @timesheet.submitted?
        @timesheet.update(status: "approved", approved_by: current_user)
        render json: @timesheet
      else
        render json: { error: "Only submitted timesheets can be approved" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def reject
    @timesheet = Timesheet.find(params[:id])
    if current_user.role == "admin" || current_user.role == "hr_manager"
      if @timesheet.submitted?
        @timesheet.update(status: "rejected")
        render json: @timesheet
      else
        render json: { error: "Only submitted timesheets can be rejected" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def destroy
    @timesheet = current_employee.timesheets.find(params[:id])
    if @timesheet.draft? || @timesheet.submitted?
      @timesheet.destroy
      render json: { message: "Timesheet deleted" }
    else
      render json: { error: "Approved or rejected timesheets cannot be deleted" }, status: :unprocessable_entity
    end
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:date, :hours_worked, :description, :task_id)
  end
end
