class CreateNovidades < ActiveRecord::Migration[5.0]
  def change
    create_table :novidades do |t|
      t.string :titulo
      t.text :descricao

      t.timestamps
    end
  end
end
