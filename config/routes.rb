Rails.application.routes.draw do
  resources :password_resets,     only: [:new, :create, :edit, :update]
  get 'sessions/new'
  get 'home', to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'contact', to: 'static_pages#contact'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts
  root 'static_pages#home'
  resources :relationships, only: [:create, :destroy]
  get  '/login',  to: 'sessions#new'
  post  '/login',  to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
