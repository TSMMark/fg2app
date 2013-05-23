class DashController < ApplicationController

  def index
    if user_signed_in? then
      @pages = current_user.pages
    else
    end
  end

end