class ReviewsController < ApplicationController
  def index
    @reviews = Review.all.order(order_param) if params[:sort].present?

    render json: @reviews, status: :ok
  end

  def show
    @review = Review.find(show_params[:id])

    render json: @review, status: :ok
  end

  private

  def order_param
    values_hash = {
      'rating' => 'rating ASC',
      '-rating' => 'rating DESC',
      'date' => 'created_at ASC',
      '-date' => 'created_at DESC'
    }
    # order by date DESC unless param is found
    if values_hash[params[:sort]].present?
      values_hash[params[:sort]]
    else
      'created_at DESC'
    end
  end

  def show_params
    params.permit(:id, :sort)
  end
end
