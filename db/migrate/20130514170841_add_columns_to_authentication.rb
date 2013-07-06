class AddColumnsToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :provider, :string, :null => false, :default => 0
    add_column :authentications, :uid, :string, :null => false, :default => 0
    add_column :authentications, :token, :string, :null => false, :default => 0
    add_column :authentications, :user_id, :int, :null => false, :default => 0

    # remove default
    change_column :authentications, :provider, :string, :null => false
    change_column :authentications, :uid, :string, :null => false
    change_column :authentications, :token, :string, :null => false
    change_column :authentications, :user_id, :string, :null => false

    add_index :authentications, :uid
    add_index :authentications, :user_id
  end
end
