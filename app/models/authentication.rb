class Authentication < ActiveRecord::Base
  include Ownable
  def get_owners
    [self.user]
  end

  
  attr_accessible :user_id, :provider, :uid, :token
  belongs_to :user

  scope :facebook, where({:provider => 'facebook'})

  def self.provider_is provider
    where({:provider => "#{provider}"})
  end

end
