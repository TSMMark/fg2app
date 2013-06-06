module Api
  module V1
    class TabsController < Api::BaseController #Api::BaseController
      # cancan
      load_and_authorize_resource # nested: :article

      # cancan strong parameters
      # permit_params :name, :page_id

      # API methods
      def index
        respond_with @tabs = Tab.all
      end

      def show
        respond_with @tab
      end

      def create
        # params[:tab].ryaml
        # @tab = Tab.build(params[:tab])
        # api_render @tab
        @tab = Tab.new(params[:tab])
        @tab.save!
        respond_with @tab
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