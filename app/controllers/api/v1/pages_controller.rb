module Api
  module V1
    class PagesController < Api::BaseController
      
      def index
        api_render @pages = Page.all
      end


    end


  end
end