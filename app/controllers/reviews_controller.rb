class ReviewsController < ApplicationController
  def index
    @reviews = Review.all

    render json: @reviews, status: :ok
  end

  def show
    @review = Review.find(show_params[:id])

    render json: @review, status: :ok
  end

  private

  def show_params
    params.permit(:id)
  end
end
