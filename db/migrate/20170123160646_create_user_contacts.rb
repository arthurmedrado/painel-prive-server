class CreateUserContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_contacts do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
