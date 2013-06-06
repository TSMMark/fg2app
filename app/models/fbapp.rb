class Fbapp < ActiveRecord::Base
  include Ownable
  def get_owners
    User.admins
  end
  
  attr_accessible :key, :namespace, :secret
  validates_presence_of :key, :namespace, :secret
  has_many :tabs, inverse_of: :fbapp
end
