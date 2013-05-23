module Api
  module V1
    class UsersController < Api::BaseController
      class User < ::User
        #def as_json(options={})
        #  super.merge(api_version: 1)
        #end
      end

      respond_to :json

      def me
        if user_signed_in? then
          respond_with User.find(current_user)
        else
          respond_with RequestError.new 403
        end
      end

      def index
        respond_with User.all
      end

      def show
        respond_with User.find(params[:id])
        #@user = User.find(params[:id])
        #pages = @user.fetch_pages
        #raise pages.to_yaml
      end

      def create
        respond_with User.create(params[:id])
      end

      def update
        respond_with User.update(params[:id], params[:user])
      end

      def destroy
        respond_with User.destroy(params[:id])
      end

    end
  end
end