class AddAdminToUsers < ActiveRecord::Migration
  def change
     remove_column :users, :role
    add_column :users, :admin, :boolean, default: false
  end
end
