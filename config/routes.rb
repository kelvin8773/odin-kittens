# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'kittens#index'
  
  get 'kittens/index'
  get 'kittens/show'
  get 'kittens/new'
  get 'kittens/edit'
  
  get 'pages/info'
  get 'pages/gallery'
  
  resource :kittens
end
