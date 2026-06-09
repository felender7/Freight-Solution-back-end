class Api::V1::Hrm::TrainingCoursesController < Api::V1::Hrm::BaseController
  def index
    @courses = TrainingCourse.where(is_active: true).order(title: :asc)
    render json: @courses
  end

  def show
    @course = TrainingCourse.find(params[:id])
    render json: @course
  end

  def enroll
    @course = TrainingCourse.find(params[:id])
    @enrollment = current_employee.enrollments.find_or_initialize_by(training_course_id: @course.id)
    @enrollment.user = current_user

    if @enrollment.persisted?
      render json: { message: "Already enrolled" }, status: :ok
    elsif @enrollment.save
      render json: @enrollment, status: :created
    else
      render json: { errors: @enrollment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
