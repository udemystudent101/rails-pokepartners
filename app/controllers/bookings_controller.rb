class BookingsController < ApplicationController
  before_action :set_pokemon, only: [:create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.pokemon = @pokemon
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @pokemon = Pokemon.find(@booking.pokemon_id)
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to dashboard_my_bookings_path(:dashboard_id), status: :see_other
    else
      redirect_to pokemon_path(Pokemon.find(@booking.pokemon_id)), status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dashboard_my_bookings_path(:dashboard_id), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end
end
