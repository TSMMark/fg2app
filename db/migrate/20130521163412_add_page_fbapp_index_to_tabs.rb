class AddPageFbappIndexToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :page_id, :integer
    change_column :tabs, :page_id, :integer, :null => false
    
    add_column :tabs, :fbapp_id, :integer
    change_column :tabs, :fbapp_id, :integer, :null => false

    add_index :tabs, [:page_id, :fbapp_id], :unique => true
  end
end
