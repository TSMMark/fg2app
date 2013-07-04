module Api
  module V1
    class PagesController < Api::V1::BaseController
      
      load_and_authorize_resource

      def index
        respond_with @pages = Page.all
      end
      
      def show
        respond_with @page
      end



    end


  end
end