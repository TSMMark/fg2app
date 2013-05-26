class Tab < ProtectedActiveRecord

  attr_accessible :name, :description
  belongs_to :page
  belongs_to :fbapp
  validates_presence_of :page, :fbapp

  has_many :users, through: :page#, as: :owners
  @keep_only = [:id, :name]
  readable_for_block { |type, ownable| @keep_only }
  readable_for  owner: [:id, :description],
                admin: [:id, :name]
  

  #owners_are {|ownable| ownable.page.users }
  #owners_are {|| raise self.page.to_yaml }

  #def get_owners
  #  self.page.users
  #end

end