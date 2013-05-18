class Page < ActiveRecord::Base
  attr_accessible :pid, :name, :category, :access_token

  # many to many with pages
  #has_many :page_users
  #has_many :users, through: :page_users
  has_and_belongs_to_many :users

  # fetch from facebook:: list of pages belonging to a user
  def self.fetch_user_pages user=@user
    @user = user
    @pages = Fb.current_user_client.client.selection.user(user.fb_auth.uid).accounts.info![:data]
    Page.add_batch @pages
  end

  # take an array of pages and add them to the database if they don't exist
  # push page to list of user's pages if not already there
  # currently stores page access_token in the page record, 
  #   but maybe it should store it in the many_to_many table
  def self.add_batch pages=@pages, user=@user
    pages.each do |p|
      # find existing page or create new page
      record = Page.where(:pid => p.id).first || Page.new
      
      # set / update all data
      record.pid = p.id
      record.access_token = p.access_token
      record.name = p.name
      record.category = p.category
      
      # push page to list of user-pages if not already there
      record.users.push user unless record.users.include? user

      # save the page
      record.save
    end
    pages
  end


end