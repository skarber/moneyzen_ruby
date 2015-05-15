class AddPercentToUsers < ActiveRecord::Migration
  def change
    add_column :credits, :percent, :string
    add_column :users, :percent, :string
  end
end
