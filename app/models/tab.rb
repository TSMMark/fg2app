class Tab < ActiveRecord::Base
  attr_accessible :name, :description
  belongs_to :page
  belongs_to :fbapp
  validates_presence_of :page, :fbapp
end
