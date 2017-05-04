class CreateParceiros < ActiveRecord::Migration[5.0]
  def change
    create_table :parceiros do |t|
      t.string :titulo
      t.string :telefone
      t.string :email
      t.string :site
      t.decimal :longitude, precision: 10, scale: 8
      t.decimal :latitude, precision: 10, scale: 8
      t.text :descricaoMapa
      t.text :descricao1
      t.text :descricao2
      t.text :descricao3

      t.timestamps
    end
  end
end
