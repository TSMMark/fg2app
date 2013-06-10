class Tab < ActiveRecord::Base
  include Ownable
  
  # API version
  include Api::V1::V1Tab

  include DoesApi


  attr_accessible :name, :description, :created_at, :updated_at,
                  :page_id, :fbapp_id, :page, :fbapp

  belongs_to :page, inverse_of: :tabs
  belongs_to :fbapp, inverse_of: :tabs

  validates_presence_of :page, :fbapp

  has_many :users, through: :page#, as: :owners


  # owners_are {|ownable| ownable.page.users }
  # owners_are {|| raise self.page.to_yaml }

  before_validation :default_values
  after_initialize  :default_values

  def default_values
    self.fbapp ||= self.page.unused_fbapp unless self.page.nil?
    # puts "self.fbapp"
    # puts self.fbapp.to_yaml
  end

  def owners
    self.users
  end
  
end