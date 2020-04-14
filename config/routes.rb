Rails.application.routes.draw do
  get 'blogs/index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
