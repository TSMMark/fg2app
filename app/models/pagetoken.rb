class Pagetoken < ActiveRecord::Base
  attr_accessible :user_id, :page_id, :token, :perms
  belongs_to :page
  belongs_to :user
  
  accepts_nested_attributes_for :page

  validates_presence_of :page
  validates_presence_of :user
  validates_presence_of :token
  validates_presence_of :perms
  serialize :perms, JSON


  def self.of_page p
    where({:page_id => p})
  end
  def self.of_user u
    where({:user_id => u})
  end
end
