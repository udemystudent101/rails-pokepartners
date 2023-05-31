class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_pokemon, only: %i[show edit update destroy]

  def index
    @pokemons = Pokemon.all
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    if @pokemon.save
      redirect_to pokemons_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @booking = Booking.new
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def update
    @pokemon = Pokemon.find(params[:id])
    @pokemon.update(pokemon_params)
    redirect_to pokemon_path(@pokemon)
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    redirect_to pokemons_path, status: :see_other
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :nature, :category, :price, :photo)
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
