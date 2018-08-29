Rails.application.routes.draw do
  root to: 'pages#about'

  get '/logout',  to: 'user_sessions#destroy', as: :logout
  get '/login',   to: 'user_sessions#new',     as: :login

  resources :user_sessions, only: [:create, :destroy]
end
