class AddLastpagefetchToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_page_fetch, :datetime
  end
end
