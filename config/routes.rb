Rails.application.routes.draw do

  resources :experts
  root to: 'experts#index'

  get '/logout',  to: 'user_sessions#destroy', as: :logout
  get '/login',   to: 'user_sessions#new',     as: :login

  resources :user_sessions, only: [:create, :destroy]
end
