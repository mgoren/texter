Rails.application.routes.draw do
  root to: "users#index"
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :contacts, except: [:index]
  end
  resources :messages, only: [:new, :create, :show]
end
