# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.ordered_by_rating_desc

    render json: ProductSerializer.new(@products), status: :ok
  end

  def show
    @product = Product.find(show_params[:id])

    render json: ProductSerializer.new(@product), status: :ok
  end

  private

  def show_params
    params.permit(:id)
  end
end
