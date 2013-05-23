class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :authenticate_user!
  def facebook
    handle_auth
  end

  def twitter
    handle_auth
    #omni = request.env["omniauth.auth"]
    #if authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid']) then
    # set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    #end

    #render :nothing => true
    #oauthorize "Twitter"
  end

  def handle_auth
    @omni = request.env["omniauth.auth"]
    # try to find existing user
    @auth = Authentication.find_by_provider_and_uid(@omni['provider'], @omni['uid'])

    #raise @auth.to_yaml
    #raise @omni.to_yaml

    session["devise.provider_data"] = @omni['info']
    if @auth and @auth.persisted? then
      # user has account
      # update token in database
      if @auth.token != @omni['credentials'].token then
        @auth.token = @omni['credentials'].token
        @auth.save
      end
      # sign them in
      sign_in_and_redirect @auth.user, :event => :authentication
      set_flash_message(:notice, :success, :kind => @omni['provider']) if is_navigational_format?
    elsif current_user
      # user signed in, wants to add an auth provider
      attach_provider
      flash[:notice] = "Successfully added your #{@omni[:provider]} account."
      sign_in_and_redirect current_user, :event => :authentication
    else
      # no user signed in, no auth exists, create new user and auth
      #raise @omni.to_yaml
      # register and sign in user
      @user = user_from_omni
      @user.save!
      @user = attach_provider @user
      sign_in_and_redirect @user, :event => :authentication
      #redirect_to new_user_registration_path
    end

  end

  # create new user from omni data
  def user_from_omni omni=@omni
    #raise omni.to_yaml
    return User.new(
      :email => omni[:info][:email],
      :name => omni[:info][:name],
      :password => pw=Devise.friendly_token[0,20],
      :password_confirmation => pw
    )
  end

  def attach_provider user=current_user
    user.authentications.create!(
      :provider => @omni['provider'],
      :uid => @omni['uid'],
      :token => @omni['credentials'].token
    )
    return user
  end


end