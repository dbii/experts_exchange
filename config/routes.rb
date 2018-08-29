Rails.application.routes.draw do
  root to: 'pages#about'

  resources :experts do
    member do
      get "friends"
      post "add_friend"
      delete "remove_friend"
    end
  end

  get '/logout',  to: 'user_sessions#destroy', as: :logout
  get '/login',   to: 'user_sessions#new',     as: :login

  resources :user_sessions, only: [:create, :destroy]
end
