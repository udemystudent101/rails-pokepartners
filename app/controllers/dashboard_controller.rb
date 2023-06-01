class DashboardController < ApplicationController
  def index
    @pokemons = Pokemon.all
    @user = current_user
    @my_pokemons = @pokemons.where(user_id: current_user)
  end

  def current_bookings
    @user = current_user
    @pokemons = Pokemon.all
    @bookings = Booking.all
    raise
  end

end
