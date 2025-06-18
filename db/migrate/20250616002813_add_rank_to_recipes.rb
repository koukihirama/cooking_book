class AddRankToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :rank, :string
  end
end
