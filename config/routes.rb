Raspas::Application.routes.draw do
  
  root to: 'raspas#index'

  delete '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'
  get '/signup', to: 'authors#new'
  get '/:username', to: 'authors#show', as: 'authors_raspas'

  resources :sessions

  resources :password_resets

  resources :authors do
    resources :relationships, only: [:create, :destroy]
  end

  resources :user_profiles do
    resources :authors
  end
   
  resources :jobs
  
  resources :origins
  
  resources :genres

  resources :raspas do
    resources :reaspas
  end

  resources :tags

end
