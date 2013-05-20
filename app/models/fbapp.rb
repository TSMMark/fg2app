class Fbapp < ActiveRecord::Base
  attr_accessible :key, :namespace, :secret
  validates_presence_of :key, :namespace, :secret
  has_many :tabs
end
