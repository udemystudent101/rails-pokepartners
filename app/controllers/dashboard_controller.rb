class DashboardController < ApplicationController
  def index
    @pokemons = Pokemon.all
    @user = current_user
    @my_pokemons = @pokemons.where(user_id: current_user)
  end

  def current_bookings
    @user = current_user
    @bookings = Booking.where(user_id: @user.id)
    @bookings.each do |booking|
      pokemon = Pokemon.find(booking.pokemon_id)
      duration = (booking.end_date - booking.start_date).to_i
      booking.total_price = (duration * pokemon.price).to_i
      booking.save
    end

  end

end
