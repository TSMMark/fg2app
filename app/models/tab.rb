class Tab < ActiveRecord::Base
  include Ownable

  attr_accessible :name, :description
  belongs_to :page
  belongs_to :fbapp
  validates_presence_of :page, :fbapp

  def get_owners
    self.page.users
  end

end