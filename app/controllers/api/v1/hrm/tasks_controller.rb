class Api::V1::Hrm::TasksController < Api::V1::Hrm::BaseController
  def index
    @tasks = current_employee.tasks.order(due_date: :asc)
    render json: @tasks
  end

  def show
    @task = current_employee.tasks.find(params[:id])
    render json: @task
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
    params.require(:task).permit(:status)
  end
end
