Rails.application.routes.draw do
  devise_for :users
  resources :pokemons do
    get "search", to: "pokemons#search"

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pokemons#index"
  resources :bookings, only: [:new, :create]
end
