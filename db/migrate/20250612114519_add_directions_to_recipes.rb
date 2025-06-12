class AddDirectionsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :directions, :text
  end
end
