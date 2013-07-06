class CreatePagetokens < ActiveRecord::Migration
  def change
    create_table :pagetokens do |t|
      t.integer :page_id
      t.integer :user_id
      t.string :token
      t.string :perms
    end

    # add not null
    change_column :pagetokens, :page_id, :integer, :null => false
    change_column :pagetokens, :user_id, :integer, :null => false
    change_column :pagetokens, :token, :string, :null => false
    change_column :pagetokens, :perms, :string, :null => false

    #add_index :pagetokens, [:page_id], :name => "index_pagetokens_on_page_id"
    #add_index :pagetokens, [:user_id], :name => "index_pagetokens_on_user_id"
    add_index :pagetokens, [:user_id, :page_id], :unique => true

  end
end
