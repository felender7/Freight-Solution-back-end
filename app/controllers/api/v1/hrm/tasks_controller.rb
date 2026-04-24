class Api::V1::Hrm::TasksController < Api::V1::Hrm::BaseController
  def index
    @tasks = current_employee.tasks.order(due_date: :asc)
    render json: @tasks
  end

  def show
    @task = current_employee.tasks.find(params[:id])
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
    @task = current_employee.tasks.find(params[:id])
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
