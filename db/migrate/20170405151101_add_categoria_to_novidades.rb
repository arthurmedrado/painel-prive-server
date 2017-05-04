class AddCategoriaToNovidades < ActiveRecord::Migration[5.0]
  def change
    add_column :novidades, :categoria, :integer
  end
end
