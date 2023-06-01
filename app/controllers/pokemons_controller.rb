class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_pokemon, only: %i[show edit update destroy]

  def index

    @pokemons = Pokemon.all
    if params["format"].present?
      if Pokemon::CATEGORIES.include?(params["format"])
        @pokemons = Pokemon.where(category: params["format"])
      else
        @pokemons = Pokemon.where(nature: params["format"])
      end
    end



    if params[:query].present?
      @pokemons = Pokemon.where("name ILIKE ?", "%#{params[:query]}%")
    end






    @pokemons = @pokemons.shuffle
    unless params["format"].present?
      respond_to do |format|
        format.html
        format.json
      end
    end
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
    array = Booking.where(pokemon_id: @pokemon.id)
    array.each do |element|
      @booking = element if element.user_id == current_user.id
    end

    # if @booking.present?
    #   @booking = Booking.where(pokemon_id: @pokemon.id, user_id: current_user.id).first
    # else
    #   @booking = Booking.new
    # end
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
    render :new
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
    params.require(:pokemon).permit(:name, :nature, :category, :price, :photo, :details)
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
