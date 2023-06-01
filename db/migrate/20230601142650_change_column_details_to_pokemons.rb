class ChangeColumnDetailsToPokemons < ActiveRecord::Migration[7.0]
  def change
    change_column :pokemons, :details, :text
  end
end
