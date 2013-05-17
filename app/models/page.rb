class Page < ActiveRecord::Base
  attr_accessible :pid, :name, :category, :access_token

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