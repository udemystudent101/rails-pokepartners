class ChangeTypeFromPokemons < ActiveRecord::Migration[7.0]
  def change
    rename_column :pokemons, :type, :nature
  end
end
