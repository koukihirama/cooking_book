class ChangeUserIdToNullableInRecipes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :recipes, :user_id, true
  end
end
