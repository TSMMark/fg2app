class CreatePagesUsers < ActiveRecord::Migration
  def change
    create_table :pages_users, :id => false do |t|
      t.integer :page_id
      t.integer :user_id
    end
  end
end
