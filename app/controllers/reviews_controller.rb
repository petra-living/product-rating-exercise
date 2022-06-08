# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    @reviews = Review.query(index_params)

    render json: @reviews, status: :ok
  end

  def create
    @review = Review.new(review_params)
      
      if @review.save
        render json: @review, status: :created
      else
        render json: @review.errors, status: :unprocessable_entity
      end
  end
  
  private

  def review_params
    params.require(:review).permit(:author, :rating, :headline, :body, :product_id)
  end

  def index_params
    params.permit(:sort_by, :order_by)
  end
end
