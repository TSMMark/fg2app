class Pagetoken < ActiveRecord::Base
  include Ownable
  
  def get_owners
    [self.user]
  end
  def get_owner
    self.user
  end
  
  attr_accessible :user_id, :page_id, :token, :perms
  belongs_to :page, inverse_of: :pagetokens
  belongs_to :user, inverse_of: :pagetokens
  
  accepts_nested_attributes_for :page

  validates_presence_of :page, :user, :token, :perms
  serialize :perms, JSON


  def self.of_page p
    where({:page_id => p})
  end
  def self.of_user u
    where({:user_id => u})
  end
end