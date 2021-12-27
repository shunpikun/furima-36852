Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'items/index'
  devise_for :users
  root to: "items#index"
  get 'items/look' do
    get 'items/look'
  end
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show]
  resources :cards, only: [:new, :create]
end
