class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :null => false, :default => 0

    # remove default
    change_column :users, :name, :string, :null => false
  end
end
