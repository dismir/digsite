Rails.application.routes.draw do
  root to: 'tickets#index'

  namespace :api do
    resource :requests, only: :create
  end

  resources :tickets, only: %i[index show]
end
