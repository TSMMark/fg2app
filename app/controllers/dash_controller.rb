class DashController < ApplicationController

  def index
    if user_signed_in? then
      @pages = current_user.pages
    else
      RequestError.new(403)
    end
  end

end