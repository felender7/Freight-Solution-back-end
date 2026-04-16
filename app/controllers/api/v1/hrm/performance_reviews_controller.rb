class Api::V1::Hrm::PerformanceReviewsController < Api::V1::Hrm::BaseController
  def index
    @reviews = current_employee.performance_reviews.order(review_date: :desc)
    render json: @reviews
  end

  def show
    @review = current_employee.performance_reviews.find(params[:id])
    render json: @review
  end

  def update
    @review = current_employee.performance_reviews.find(params[:id])
    if @review.update(review_params)
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:performance_review).permit(:feedback, :status)
  end
end
