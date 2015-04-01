Rails.application.routes.draw do
  root to: "users#index"
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :contacts
  end
  resources :messages, only: [:new, :create, :show, :index]

  # devise_scope :user do
  #   root to: "devise/registrations#edit"
  # end
end
