class CreateEventos < ActiveRecord::Migration[5.0]
  def change
    create_table :eventos do |t|
      t.string :titulo
      t.date :data
      t.string :telefone
      t.string :email
      t.string :site
      t.decimal :longitude, precision: 10, scale: 8
      t.decimal :latitude, precision: 10, scale: 8
      t.text :descricao

      t.timestamps
    end
  end
end
