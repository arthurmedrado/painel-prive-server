class AddColumnsToParceiros < ActiveRecord::Migration[5.0]
  def change
    add_column :parceiros, :instagram, :string
    add_column :parceiros, :facebook, :string
  end
end
