Rails.application.routes.draw do
  devise_for :users
  resources :pokemons, only: [:index, :new, :create, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pokemons#index"
  resources :bookings, only: [:new, :create]
end
