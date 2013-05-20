class Page < ActiveRecord::Base
  attr_accessible :pid, :name, :category #, :access_token

  # many to many with pages
  has_many :pagetokens, :dependent => :destroy
  has_many :users, through: :pagetokens
  accepts_nested_attributes_for :pagetokens, :allow_destroy => false
  #has_and_belongs_to_many :users

  has_many :tabs

  # fetch from facebook:: list of pages belonging to a user
  def self.fetch_user_pages user=@user
    @user = user
    fbpages = Fb.current_user_client.client.selection.user(user.fb_auth.uid).accounts.info![:data]
    Page.add_batch fbpages
  end

  # take an array of pages and add them to the database if they don't exist
  # push page to list of user's pages if not already there
  # currently stores page access_token in the page record, 
  #   but maybe it should store it in the join table
  def self.add_batch fbpages, user=@user
    fbpages.each do |fbp|
      # find existing page or create new page
      page = Page.where(:pid => fbp.id).first || Page.new
      
      # set / update all data
      page.pid = fbp.id

      page.name = fbp.name
      page.category = fbp.category
      
      # save the page
      page.save

      # store token and perms in join table
      # move this to its own method
      pt = page.pagetokens.of_user(user).first || page.pagetokens.build
      pt.token  = fbp.access_token
      pt.user   = user
      pt.page   = page
      pt.perms  = fbp.perms
      pt.save

    end
    fbpages
  end


end