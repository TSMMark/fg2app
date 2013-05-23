module Api
  module V1
    class UsersController < Api::BaseController
      respond_to :json

      def index
        respond_with User.all
      end

      def show
        respond_with User.find(params[:id])
        #@user = User.find(params[:id])
        #ages = @user.fetch_pages
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