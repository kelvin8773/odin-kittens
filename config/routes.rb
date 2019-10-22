Rails.application.routes.draw do
  
  root to: 'kittens#index'

  get 'kittens/index', to: 'kittens#index'
  get 'kittens/show'
  # get 'kittens/new'
  # get 'kittens/edit'
  
  resource :kittens
end
