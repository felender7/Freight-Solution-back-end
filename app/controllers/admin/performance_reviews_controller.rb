class Admin::PerformanceReviewsController < Admin::BaseController
  before_action :set_performance_review, only: [ :show, :edit, :update, :destroy ]

  def index
    @performance_reviews = PerformanceReview.includes(:employee, :reviewer).order(created_at: :desc)
  end

  def show
  end

  def new
    @performance_review = PerformanceReview.new
    @employees = Employee.all
  end

  def create
    @performance_review = PerformanceReview.new(performance_review_params)
    if @performance_review.save
      redirect_to admin_performance_reviews_path, notice: "Performance review was successfully created."
    else
      @employees = Employee.all
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @employees = Employee.all
    @users = User.all
  end

  def update
    if @performance_review.update(performance_review_params)
      redirect_to admin_performance_reviews_path, notice: "Performance review was successfully updated."
    else
      @employees = Employee.all
      @users = User.all
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @performance_review.destroy
    redirect_to admin_performance_reviews_path, notice: "Performance review was successfully deleted."
  end

  private

  def set_performance_review
    @performance_review = PerformanceReview.find(params[:id])
  end

  def performance_review_params
    params.require(:performance_review).permit(:employee_id, :reviewer_id, :rating, :feedback, :review_cycle, :review_date, :status)
  end
end
