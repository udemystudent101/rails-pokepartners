class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_pokemon, only: %i[show edit update destroy]

  def index

    @pokemons = params["format"].nil? ? Pokemon.all : Pokemon.where(category: params["format"])
    if params[:query].present?
      @pokemons = Pokemon.where("name LIKE ?", "%#{params[:query].capitalize}%")
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render :search, locals: { pokemons: Pokemon.where("name LIKE ?", "%#{params[:query].capitalize}%") } }
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

  def search
    @pokemons = Pokemon.where("name LIKE ?", "%#{params[:query].capitalize}%")
    render :index
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :nature, :category, :price, :photo)
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
