class CreateTabs < ActiveRecord::Migration
  def self.up
    create_table :tabs do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    change_column :tabs, :name, :string, :null => false
    change_column :tabs, :description, :string, :null => false
    
  end

  def self.down
    drop_table :tabs
  end
end
