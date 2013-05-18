class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
    pages = @user.fetch_pages
    raise pages.to_yaml
    #client = @user.fb_client
    #raise client.selection.me.info!.to_yaml
    #raise fb.client.selection.me.info!.to_yaml
    #raise @user.fetch_fb_pages.to_yaml
  end


end
