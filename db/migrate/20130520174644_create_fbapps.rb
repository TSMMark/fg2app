class CreateFbapps < ActiveRecord::Migration
  def self.up
    create_table :fbapps do |t|
      t.string  :namespace
      t.integer :key
      t.string  :secret
      t.timestamps
    end

    change_column :fbapps, :namespace, :string, :null => false
    change_column :fbapps, :key, :integer, :null => false
    change_column :fbapps, :secret, :string, :null => false
  end

  def self.down
    drop_table :fbapps
  end
end
