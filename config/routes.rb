Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_status', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'places', to: 'places#search'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'


end
