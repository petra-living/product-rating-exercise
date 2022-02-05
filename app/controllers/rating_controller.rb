
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

  PRODUCT_RATING_SAVE_ERROR_MESSAGE = 'Incorrect parameters for ProductRating. Valid paramters in valid_params.'.freeze
  PRODUCT_DOES_NOT_EXIST_ERROR_MESSAGE = 'This product does not exist.'.freeze
  PRODUCT_RATING_SORT_ERROR_MESSAGE = 'Valid sort_by values are [rating, created_at]. Valid sort_order paramters are [asc, desc]'.freeze
  VALID_CREATE_PARAMS = {
    :author => 'string, required',
    :rating => 'integer (1-5 inclusive), required',
    :review_title => 'string, required',
    :review_body => 'text, optional',
    :author => 'string, required',
  }.freeze

  def index
    return render :json => { :status => 404, :message => PRODUCT_DOES_NOT_EXIST_ERROR_MESSAGE, :id => params[:id] }, :status => 404 unless Product.exists?(params[:id])
    sort_by = index_params[:sort_by] || SortBy::CREATED_AT
    sort_order = index_params[:sort_order] || SortOrder::DESC

    return render :json => { :status => 400, :message => PRODUCT_RATING_SORT_ERROR_MESSAGE }, :status => 400 if !SortBy::ALL.include?(sort_by) || !SortOrder::ALL.include?(sort_order)

    @product_ratings = Product.find(index_params[:id]).product_ratings.order(sort_by + ' ' + sort_order)

    render json: @product_ratings, status: :ok
  end

  def create
    return render :json => { :status => 404, :message => PRODUCT_DOES_NOT_EXIST_ERROR_MESSAGE, :id => params[:id] }, :status => 404 unless Product.exists?(params[:id])

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
    else
      render :json => { :status => 400, :message => PRODUCT_RATING_SAVE_ERROR_MESSAGE, :valid_params => VALID_CREATE_PARAMS }, :status => 400
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
