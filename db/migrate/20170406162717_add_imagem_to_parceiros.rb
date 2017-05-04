class AddImagemToParceiros < ActiveRecord::Migration[5.0]
  def change
    add_column :parceiros, :imagem, :string
  end
end
