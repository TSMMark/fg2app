class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
    raise @user.fetch_fb.to_yaml
  end


end
