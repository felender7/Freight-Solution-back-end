class Api::V1::Hrm::TasksController < Api::V1::Hrm::BaseController
  def index
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @tasks = Task.all.order(due_date: :asc)
    elsif current_employee
      @tasks = current_employee.tasks.order(due_date: :asc)
    else
      @tasks = []
    end
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def create
    @task = Task.new(task_params)
    @task.assigned_by = current_user
    @task.user = current_user # Link user_id

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:status, :title, :description, :priority, :due_date, :employee_id)
  end
end
