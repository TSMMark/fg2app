class User < ActiveRecord::Base
  include Ownerable
  include Ownable

  # API version
  include Api::V1::V1User

  def owners
    [self]
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :name

          # omniauth (no auth table) stuff
          #:provider,  
          #:uid        # social user id

  has_many :authentications, :dependent => :destroy, inverse_of: :user
  accepts_nested_attributes_for :authentications, :allow_destroy => true

  # many to many with pages
  has_many :pagetokens, :dependent => :destroy, inverse_of: :user
  has_many :pages, :through => :pagetokens
  accepts_nested_attributes_for :pagetokens, :allow_destroy => false
  #has_and_belongs_to_many :pages

  # 
  has_many :tabs, through: :pages

  # 
  # has_many :layouts, through: :layout_editor
  # has_many :created_layouts, inverse_of: :creator
  # has_many :layouts, inverse_of: :user
  has_many :layouts, through: :layout_editors
  has_many :layout_editors, inverse_of: :user

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def become_editor_of layout, &block
    le = LayoutEditor.new
    le.user   = self
    le.layout = layout
    block && block.call(le)
    le
  end

  def self.new_guest
    new {|u| u.guest = true}
  end

  def token p
    self.pagetokens.where({:page_id => p})
  end
  
  # get the auth data (token etc) of user
  def fb_auth
    @auth ||= self.authentications.facebook.first
  end

  # set Fb Graph client of user
  def fb_client
    self.fb_auth
    return unless !@auth.nil?
    Fb.set_current_user(@auth.token).client
  end

  def fetch_fb
    self.fb_client
    Fb.current_user_client.client.selection.user(@auth.uid).info!
  end

  def fetch_pages
    self.fb_client
    Page.fetch_user_pages(self)
  end

  # admin stuff
  def admin?
    !!self.admin
  end

  # is guest?
  def guest?
    !!self.guest
  end

  # get all admins users
  def self.admins
    where(admin: true)
  end


end
