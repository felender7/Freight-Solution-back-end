class Api::V1::Hrm::EnrollmentsController < Api::V1::Hrm::BaseController
  def index
    @enrollments = current_employee.enrollments.includes(:training_course).order(created_at: :desc)
    render json: @enrollments.as_json(include: :training_course)
  end

  def show
    @enrollment = current_employee.enrollments.find(params[:id])
    render json: @enrollment.as_json(include: :training_course)
  end

  def update
    @enrollment = current_employee.enrollments.find(params[:id])
    if @enrollment.update(enrollment_params)
      render json: @enrollment
    else
      render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:progress, :is_completed, :completed_at)
  end
end
