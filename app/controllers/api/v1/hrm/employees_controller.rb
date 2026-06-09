class Api::V1::Hrm::EmployeesController < Api::V1::Hrm::BaseController
  before_action :authorize_hr_manager, except: [ :index, :show ]

  def index
    @employees = Employee.all

    if params[:search].present?
      term = "%#{params[:search]}%"
      @employees = @employees.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", term, term, term)
    end

    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 20

    total = @employees.count
    @employees = @employees.offset((page - 1) * per_page).limit(per_page)

    render json: {
      users: @employees.as_json(methods: [ :full_name ]),
      total: total,
      page: page,
      per_page: per_page
    }
  end

  def show
    @employee = Employee.find(params[:id])
    render json: @employee.as_json(
      methods: [ :full_name ],
      include: {
        manager: { only: [ :id, :first_name, :last_name ] }
      }
    )
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Employee not found" }, status: :not_found
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee.as_json(methods: [ :full_name ]), status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(employee_params)
      render json: @employee.as_json(methods: [ :full_name ])
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Employee not found" }, status: :not_found
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    render json: { message: "Employee deleted successfully" }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Employee not found" }, status: :not_found
  end

  private

  def authorize_hr_manager
    unless current_user.role.in?(%w[admin hr_manager])
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone, :position, :department, :salary, :hire_date, :employee_code, :manager_id, :employment_status, :education_background, :address, :city, :state, :country, :zip_code)
  end
end
