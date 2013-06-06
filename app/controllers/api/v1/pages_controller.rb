module Api
  module V1
    class PagesController < Api::BaseController
      
      def index
        respond_with @pages = Page.all
      end


    end


  end
end