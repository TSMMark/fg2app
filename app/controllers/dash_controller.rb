class DashController < ApplicationController

  def index
    # make new guest if not signed in
    # => make cron to delete unused guests
    if user_signed_in? then
      @pages = current_user.pages
      @current_user = current_user.as_json
      # @route = params[:route].present? ? 
      #           params[:route].downcase.gsub(/[^0-9a-z\/]/, '') :
      #           ''
    else
      # redirect to signin path
      #   TODO: better logic for this
      redirect_to user_omniauth_authorize_path(:facebook)
    end
  end

end