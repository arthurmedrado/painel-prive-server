class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.string :category
      t.string :title

      t.timestamps
    end
  end
end
