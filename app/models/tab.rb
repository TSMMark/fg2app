class Tab < ActiveRecord::Base
  include Ownable
  attr_accessible :name, :description
  belongs_to :page
  belongs_to :fbapp
  validates_presence_of :page, :fbapp

  has_many :users, through: :page#, as: :owners


  #owners_are {|ownable| ownable.page.users }
  #owners_are {|| raise self.page.to_yaml }

  #def get_owners
  #  self.page.users
  #end

end