class Admin::EmployeesController < Admin::BaseController
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
      render :new, status: :unprocessable_content
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
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to admin_employees_path, notice: "Employee was successfully deleted."
  end

  private

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :email, :phone, :position, :department, :salary, :hire_date,
      :address, :city, :state, :country, :zip_code, :employee_code, :manager_id, :employment_status, :education_background,
      :profile_photo, :contract, :appointment_letter, :user_id
    )
  end
end
