Rails.application.routes.draw do
  root to: 'pages#about'

  resources :experts do
    member do
      get "friends"
    end
  end

  post '/experts/:id/add_friend/:friend_id', to: 'experts#add_friend', as: 'add_friend_experts'
  delete '/experts/:id/remove_friend/:friend_id', to: 'experts#remove_friend', as: 'remove_friend_experts'


  get '/logout',  to: 'user_sessions#destroy', as: :logout
  get '/login',   to: 'user_sessions#new',     as: :login

  resources :user_sessions, only: [:create, :destroy]
end
