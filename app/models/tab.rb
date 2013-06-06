class Tab < ActiveRecord::Base
  include Ownable
  
  # API version
  include Api::V1::V1Tab

  include DoesApi


  attr_accessible :id, :name, :description, :created_at, :updated_at, :page_id, :fbapp_id

  belongs_to :page
  belongs_to :fbapp
  validates_presence_of :page, :fbapp

  has_many :users, through: :page#, as: :owners


  # owners_are {|ownable| ownable.page.users }
  # owners_are {|| raise self.page.to_yaml }

  def owners
    page    = self.page
    owners  = page ? page.owners : []
  end
  
end