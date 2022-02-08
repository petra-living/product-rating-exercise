# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reviews
  resources :product, only: [:show, :index]
end
