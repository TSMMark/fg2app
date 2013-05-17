class Authentication < ActiveRecord::Base
  
  attr_accessible :user_id, :provider, :uid, :token
  belongs_to :user

  scope :facebook, where({:provider => 'facebook'})

  def self.provider_is provider
    where({:provider => "#{provider}"})
  end

end
