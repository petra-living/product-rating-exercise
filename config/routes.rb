# frozen_string_literal: true

Rails.application.routes.draw do
  resources :product, only: [:show, :index]
  resources :reviews, only: [:index, :create]
end
