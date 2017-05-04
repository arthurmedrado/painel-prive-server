class ChangeNovidadesColumnTitulo < ActiveRecord::Migration[5.0]
  def change
    rename_column :novidades, :titulo, :name
  end
end
