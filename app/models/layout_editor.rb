class LayoutEditor < ActiveRecord::Base
  attr_accessible :active, :editor_id, :editor_type, :layout_id, :user_id

  belongs_to :user, inverse_of: :layout_editors
  belongs_to :layout, inverse_of: :layout_editors
end
