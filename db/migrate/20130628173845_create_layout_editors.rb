class CreateLayoutEditors < ActiveRecord::Migration
  def change
    create_table :layout_editors do |t|
      t.integer :user_id
      t.integer :layout_id
      t.integer :editor_id
      t.string :editor_type
      t.boolean :active

      t.timestamps
    end
  end
end
