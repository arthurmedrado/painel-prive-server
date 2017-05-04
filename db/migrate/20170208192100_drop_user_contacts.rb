class DropUserContacts < ActiveRecord::Migration[5.0]
  def up
    drop_table :user_contacts
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
