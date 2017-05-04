class RemoveEmailFromParceiros < ActiveRecord::Migration[5.0]
  def change
    remove_column :parceiros, :email, :string
  end
end
