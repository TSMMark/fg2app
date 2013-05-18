class User < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
          :remember_me, :name

          # omniauth (no auth table) stuff
          #:provider,  
          #:uid        # social user id

  has_many :authentications, :dependent => :destroy

  # many to many with pages
  #has_many :page_users
  has_and_belongs_to_many :pages

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  def fb_auth
    @auth ||= self.authentications.facebook.first
    #puts self.to_yaml
    #raise self.authentications.to_yaml
    #raise Authentication.where("provider"=>"facebook").to_yaml
    #raise @auth.to_yaml
  end

  def fb_client
    self.fb_auth
    return unless !@auth.nil?
    Fb.set_current_user(@auth.token).client
    #@client ||= FBGraph::Client.new(
    #  client_id: ENV['FACEBOOK_KEY'],
    #  secret_id: ENV['FACEBOOK_SECRET'],
    #  token:     @auth.token
    #)
  end

  def fetch_fb
    self.fb_client
    @client.selection.user(@auth.uid).info!
    #self.fb_client.selection.user(@auth.uid).info!
    #FbGraph::User.me(@auth.token)
    #FbGraph::User.fetch(@auth.uid)
  end

  def fetch_pages
    self.fb_client
    Page.fetch_user_pages(self)
  end


end
