# frozen_string_literal: true

class ProductController < ApplicationController
  def index
    @products = Product.all.sort_by(&:average_rating).reverse

    render json: @products, status: :ok
  end

  def show
    @product = Product.find(show_params[:id])

    render json: @product, status: :ok
  end

  private

  def show_params
    params.permit(:id)
  end
end
