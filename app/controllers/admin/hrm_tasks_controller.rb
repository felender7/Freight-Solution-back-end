class Admin::HrmTasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = Task.includes(:employee, :assigned_by).order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
    @employees = Employee.all
    @users = User.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to admin_hrm_tasks_path, notice: "Task was successfully created."
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
    if @task.update(task_params)
      redirect_to admin_hrm_tasks_path, notice: "Task was successfully updated."
    else
      @employees = Employee.all
      @users = User.all
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to admin_hrm_tasks_path, notice: "Task was successfully deleted."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:employee_id, :assigned_by_id, :title, :description, :priority, :status, :due_date)
  end
end
