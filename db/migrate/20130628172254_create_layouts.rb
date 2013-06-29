class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.integer :creator_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
