module Api
  module V1
    class UsersController < Api::BaseController
      load_and_authorize_resource

      def initialize
        self.set_table :user
      end

      def me
        if user_signed_in? then
          respond_with @@table.find(current_user)
        else
          respond_with RequestError.new 403
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


      def show
        api_render @user
      end


    end


  end
end