
class RatingController < ApplicationController
  def index
    @product_ratings = Product.find(show_params[:id]).product_ratings.order(created_at: :desc)

    render json: @product_ratings, status: :ok
  end

  def create
    @new_product_rating = ProductRating.new(
      :author => create_params[:author],
      :rating => create_params[:rating],
      :review_title => create_params[:review_title],
      :review_body => create_params[:review_body],
      :product_id => create_params[:id]
    )
    if @new_product_rating.save
      render :json => {
        :id => @new_product_rating.id
      }
    end
  end

  private

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:author, :rating, :review_title, :review_body, :id)
  end
end
