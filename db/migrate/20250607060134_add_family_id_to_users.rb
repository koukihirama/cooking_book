class AddFamilyIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :family_id, :integer
  end
end
