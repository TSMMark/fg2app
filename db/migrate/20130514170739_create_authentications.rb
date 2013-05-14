class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|

      t.timestamps
    end
  end
end
