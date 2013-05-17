class Authentication < ActiveRecord::Base
  
  attr_accessible :user_id, :provider, :uid, :token, :token_secret
  belongs_to :user

  scope :facebook, where({:provider => 'facebook'})

  def self.provider_is provider
    where({:provider => 'facebook'})
  end

end
