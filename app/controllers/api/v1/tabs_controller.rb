module Api
  module V1
    class TabsController < Api::BaseController #Api::BaseController
      # cancan
      load_and_authorize_resource # nested: :article

      # cancan_strong_parameters
      # permit_params :name, :page_id

      # API methods
      def index
        api_render @tabs = Tab.all
      end

      def show
        api_render @tab
        # api_render(@tab, @tab.ownerable_type_of(current_user))
      end

      def create
        @tab = Tab.create(params[:tab])
        api_render @tab, @tab.ownerable_type_of(current_user)
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