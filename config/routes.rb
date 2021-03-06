Rails.application.routes.draw do
  get 'comments/create'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root "movies#index"
  get "dashboard", to:"movies#dashboard", as: "dashboard"
  resources :movies, only: %i[index show] do
    resources :comments
  end
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:show]
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users#new_guest'
    post 'users/guest_admin_sign_in', to: 'users#new_admin_guest'
  end
end
