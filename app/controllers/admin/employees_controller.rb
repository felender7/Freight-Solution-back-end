class Admin::EmployeesController < Admin::BaseController
  before_action :require_login
  helper_method :current_user
  layout "admin"

  def index
    @employees = Employee.all.order(created_at: :desc)
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to admin_employees_path, notice: "Employee was successfully created."
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to admin_employees_path, notice: "Employee was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to admin_employees_path, notice: "Employee was successfully deleted."
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to admin_login_path, alert: "Please log in first"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :email, :phone, :position, :department, :salary, :hire_date,
      :address, :city, :state, :country, :zip_code, :employee_code, :manager_id, :employment_status, :education_background,
      :profile_photo, :contract, :appointment_letter, :user_id
    )
  end
end
