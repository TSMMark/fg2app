class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
    pages = @user.fetch_pages
    raise pages.to_yaml
  end


end
