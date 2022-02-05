
class RatingController < ApplicationController
  module SortBy
    ALL = [
      RATING = 'rating',
      CREATED_AT = 'created_at'
    ].freeze
  end

  module SortOrder
    ALL = [
      DESC = 'desc',
      ASC = 'asc'
    ].freeze
  end

  def index
    sort_by = index_params[:sort_by] || SortBy::CREATED_AT
    sort_order = index_params[:sort_order] || SortOrder::DESC

    @product_ratings = Product.find(index_params[:id]).product_ratings.order(sort_by + ' ' + sort_order)

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

  def index_params
    params.permit(:id, :sort_by, :sort_order)
  end

  def create_params
    params.permit(:author, :rating, :review_title, :review_body, :id)
  end
end
