Rails.application.routes.draw do
  get 'blogs/index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :blogs
end
