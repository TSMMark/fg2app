class DashController < ApplicationController

  def index
    if user_signed_in? then
      @pages = current_user.pages
      # @route = params[:route].present? ? 
      #           params[:route].downcase.gsub(/[^0-9a-z\/]/, '') :
      #           ''
    else
      RequestError.new(403)
    end
  end

end