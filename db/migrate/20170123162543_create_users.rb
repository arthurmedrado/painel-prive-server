class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :fb_id
      t.string :profile
      t.string :auth_token

      t.timestamps
    end
  end
end
