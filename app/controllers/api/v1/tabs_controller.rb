module Api
  module V1
    class TabsController < Api::BaseController #Api::BaseController
      # cancan
      load_and_authorize_resource # nested: :article

      # cancan strong parameters
      # permit_params :name, :page_id

      # API methods
      def index
        api_render @tabs = Tab.all
      end

      def show
        api_render @tab
      end

      def create
        params.require(:tab).permit!
        # params[:tab].ryaml
        # @tab = Tab.build(params[:tab])
        # api_render @tab
        respond_with params
      end

      def update
        respond_with Tab.update_attributes!(params[:tab])
      end

      def destroy
        respond_with @tab.destroy
      end



    end
  end
end