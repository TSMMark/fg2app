class Page < ActiveRecord::Base
  attr_accessible :pid, :name, :category, :access_token

  # many to many with pages
  #has_many :page_users
  #has_many :users, through: :page_users
  has_and_belongs_to_many :users


  def fetch_user_pages uid
    @pages = self.fb_client.selection.user(uid).accounts.info!
    Page.add_batch @pages
    @pages
  end

  def self.add_batch pages
    puts pages.to_yaml
    pages.each do |page|
      puts page
    end
    pages
  end

end