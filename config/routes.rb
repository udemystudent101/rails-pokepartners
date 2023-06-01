Rails.application.routes.draw do
  devise_for :users
  root "pokemons#index"
  resources :pokemons do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:show, :destroy, :update]
  resources :dashboard, only: %i[index] do
    get "my_boookings", to: "dashboard#current_bookings"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
