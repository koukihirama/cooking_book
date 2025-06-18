class AddRequiredTimeToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :required_time, :integer
  end
end
