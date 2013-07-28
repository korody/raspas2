Raspas::Application.routes.draw do
  
  get "comments/index"
  get "comments/new"
  root to: 'raspas#index'

  delete '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'
  get '/signup', to: 'authors#new'
  get '/authors/:username', to: 'authors#show', as: 'authors_raspas'
  get '/:username/feed', to: 'authors#feed', as: 'feed'

  resources :sessions

  resources :password_resets

  resources :authors do
    resources :relationships, only: [:create, :destroy]
    resources :comments
    resources :attachments
  end

  resources :attachments

  resources :user_profiles

  resources :public_profiles

  resources :jobs
  
  resources :origins do
    resources :comments
  end
  
  resources :genres

  resources :raspas do
    resources :reaspas
    resources :comments
  end

  resources :tags

end
