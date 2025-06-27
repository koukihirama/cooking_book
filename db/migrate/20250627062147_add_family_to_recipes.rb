class AddFamilyToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_reference :recipes, :family, null: true, foreign_key: true
  end
end
