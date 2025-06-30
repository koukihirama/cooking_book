class AddCodeToFamilies < ActiveRecord::Migration[7.2]
  def change
    add_column :families, :code, :string
  end
end
