class Api::V1::Hrm::LeaveRequestsController < Api::V1::Hrm::BaseController
  include Rails.application.routes.url_helpers

  def index
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @leave_requests = LeaveRequest.all.order(start_date: :desc)
    elsif current_employee
      @leave_requests = current_employee.leave_requests.order(start_date: :desc)
    else
      @leave_requests = []
    end
    render json: @leave_requests.as_json(
      methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ],
      include: { employee: { only: [ :first_name, :last_name ] } }
    )
  end

  def create
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @leave_request = current_employee.leave_requests.new(leave_request_params)
    @leave_request.status = "pending"
    @leave_request.user = current_user

    if @leave_request.save
      render json: @leave_request.as_json(methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ]), status: :created
    else
      render json: { errors: @leave_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @leave_request = current_employee.leave_requests.find(params[:id])
    if @leave_request.status == "pending"
      if @leave_request.update(leave_request_params)
        render json: @leave_request.as_json(methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ])
      else
        render json: { errors: @leave_request.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Only pending requests can be edited" }, status: :unprocessable_entity
    end
  end

  def show
    @leave_request = LeaveRequest.find(params[:id])
    render json: @leave_request.as_json(methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ])
  end

  def approve
    @leave_request = LeaveRequest.find(params[:id])
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @leave_request.update(status: "approved", approved_by: current_user)
      render json: @leave_request.as_json(methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ])
    else
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def reject
    @leave_request = LeaveRequest.find(params[:id])
    if current_user.role == "admin" || current_user.role == "hr_manager"
      @leave_request.update(status: "rejected")
      render json: @leave_request.as_json(methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ])
    else
      render json: { error: "Unauthorized" }, status: :forbidden
    end
  end

  def upload_medical_certificate
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @leave_request = current_employee.leave_requests.find(params[:id])
    if @leave_request.update(medical_certificate: params[:medical_certificate])
      render json: @leave_request.as_json(methods: [ :number_of_days, :medical_certificate_attached, :study_timetable_attached, :medical_certificate_url, :study_timetable_url, :document_urls ])
    else
      render json: { errors: @leave_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    unless current_employee
      return render json: { error: "Employee record not found" }, status: :forbidden
    end

    @leave_request = current_employee.leave_requests.find(params[:id])
    if @leave_request.status == "pending"
      @leave_request.destroy
      render json: { message: "Leave request cancelled" }
    else
      render json: { error: "Only pending requests can be cancelled" }, status: :unprocessable_entity
    end
  end

  private

  def leave_request_params
    params.require(:leave_request).permit(:leave_type, :start_date, :end_date, :reason, :medical_certificate, :study_timetable, documents: [])
  end
end
