class AddMaterialsAndEaseRankToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :materials, :text
    add_column :recipes, :ease_rank, :integer
  end
end
