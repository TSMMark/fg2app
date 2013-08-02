class DashController < ApplicationController

  # load_and_authorize_resource :layout, through: :current_user, only: :index
  def index
    # make new guest if not signed in
    # => make cron to delete unused guests
    if user_signed_in? then
      @layouts    = current_user.layouts
      authorize_collection!  :show, @layouts

    else
      # redirect to signin path
      #   TODO: better logic for this
      redirect_to user_omniauth_authorize_path(:facebook)
    end
  end

end