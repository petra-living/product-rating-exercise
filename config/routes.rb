# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reviews
  resources :products, only: [:show, :index]
end
