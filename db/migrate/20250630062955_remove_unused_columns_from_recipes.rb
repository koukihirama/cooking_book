class RemoveUnusedColumnsFromRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_column :recipes, :materials, :text
    remove_column :recipes, :ease_rank, :integer
    remove_column :recipes, :directions, :text
    remove_column :recipes, :rank, :string
  end
end
