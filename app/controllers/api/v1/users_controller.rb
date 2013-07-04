module Api
  module V1
    class UsersController < Api::V1::BaseController
      
      load_and_authorize_resource except: [:me]

      def me
        if user_signed_in? then
          respond_with User.find(current_user)
        else
          raise CanCan::AccessDenied.new
        end
      end

      def create
        @user = params[:user] ? User.new(params[:user]) : User.new_guest
        if @user.save!
          api_render @user
        else
          api_render {:failed}
        end
      end


      def index
        respond_with @users = User.all
      end

      def show
        respond_with get_by_id
      end


    end


  end
end