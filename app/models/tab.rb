class Tab < ProtectedActiveRecord

  attr_accessible :name, :description
  belongs_to :page
  belongs_to :fbapp
  validates_presence_of :page, :fbapp

  @keep_only = [:id, :name]
  readable_by {|ownable| @keep_only}

  owners_are {|ownable| ownable.page.users }
  #owners_are {|| raise self.page.to_yaml }

  #def get_owners
  #  self.page.users
  #end

end