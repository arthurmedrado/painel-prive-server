class ChangeParceirosColumnTitulo < ActiveRecord::Migration[5.0]
  def change
    rename_column :parceiros, :titulo, :name
  end
end
