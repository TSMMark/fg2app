class Layout < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :tabs, inverse_of: :layout

  has_many :users, through: :layout_editors
  has_many :layout_editors, inverse_of: :layout
end
