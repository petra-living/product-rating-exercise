
class RatingController < ApplicationController
  def index
    @product_ratings = Product.find(show_params[:id]).product_ratings.order(created_at: :desc)

    render json: @product_ratings, status: :ok
  end

  private

  def show_params
    params.permit(:id)
  end
end
