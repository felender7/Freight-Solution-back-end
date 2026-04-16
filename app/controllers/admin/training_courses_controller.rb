class Admin::TrainingCoursesController < ApplicationController
  before_action :set_training_course, only: [ :show, :edit, :update, :destroy ]

  def index
    @training_courses = TrainingCourse.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @training_course = TrainingCourse.new
  end

  def create
    @training_course = TrainingCourse.new(training_course_params)
    if @training_course.save
      redirect_to admin_training_courses_path, notice: "Training course was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @training_course.update(training_course_params)
      redirect_to admin_training_courses_path, notice: "Training course was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @training_course.destroy
    redirect_to admin_training_courses_path, notice: "Training course was successfully deleted."
  end

  private

  def set_training_course
    @training_course = TrainingCourse.find(params[:id])
  end

  def training_course_params
    params.require(:training_course).permit(:title, :description, :category, :duration_hours, :certificate_url, :is_active)
  end
end
