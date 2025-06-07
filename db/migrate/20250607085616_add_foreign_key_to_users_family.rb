class AddForeignKeyToUsersFamily < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :users, :families
  end
end
