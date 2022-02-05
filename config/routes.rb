# frozen_string_literal: true

Rails.application.routes.draw do
  resources :product, only: [:show, :index]
  get "product/:id/product_ratings" => "rating#index"
end
