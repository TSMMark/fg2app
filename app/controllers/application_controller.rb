class ApplicationController < ActionController::Base

  protect_from_forgery

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Access Denied"
  #   redirect_to root_url
  # end

  def authorize_collection! action, collection
    collection.map do |model|
      authorize! action, model
    end
  end

  def current_user
    @current_user ||= super
  end
  helper_method :current_user

  protected
  #
  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end
  helper_method :permitted_params

end