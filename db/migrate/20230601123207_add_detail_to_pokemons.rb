class AddDetailToPokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :details, :string
  end
end
