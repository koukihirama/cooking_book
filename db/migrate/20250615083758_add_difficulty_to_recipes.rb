class AddDifficultyToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :difficulty, :integer
  end
end
