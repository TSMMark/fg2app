class RemoveCreatorIdFromLayouts < ActiveRecord::Migration
  def change
    remove_column :layouts, :creator_id
  end
end
