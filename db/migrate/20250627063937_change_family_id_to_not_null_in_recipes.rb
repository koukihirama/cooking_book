class ChangeFamilyIdToNotNullInRecipes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :recipes, :family_id, false
  end
end
