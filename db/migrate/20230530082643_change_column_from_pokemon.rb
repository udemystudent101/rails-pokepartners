class ChangeColumnFromPokemon < ActiveRecord::Migration[7.0]
  def change
    remove_column :pokemons, :price_by_day, :string
    add_column :pokemons, :price, :integer
  end
end
