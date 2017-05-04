class CreatePushes < ActiveRecord::Migration[5.0]
  def change
    create_table :pushes do |t|
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
