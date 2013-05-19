class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :pid, :limit => 8
      t.string :name
      t.string :category
      #t.string :access_token
      t.timestamps
    end

    # add NOT NULL
    change_column :pages, :pid, :integer, :limit => 8, :null => false
    change_column :pages, :name, :string, :null => false
    change_column :pages, :category, :string, :null => false
    #change_column :pages, :access_token, :string, :null => false
  end

  def self.down
    drop_table :pages
  end
end
