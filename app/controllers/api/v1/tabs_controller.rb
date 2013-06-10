module Api
  module V1
    class TabsController < Api::BaseController #Api::BaseController

      rescue_from Exceptions::TabLimitException do |exception|
        respond_with_error exception.message
      end
      
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
        @tab = Tab.new(params[:tab])
        if @tab.save!
          respond_with @tab
        else
          respond_with_error @tab.errors.full_messages
        end
      end

      def update
        if @tab.update_attributes!(params[:tab])
          respond_with @tab
        else
          respond_with_error @tab.errors.full_messages
        end
      end

      def destroy
        if @tab.destroy
          respond_with_success "deleted tab with id: #{@tab.id}"
        else
          respond_with_error @tab.errors.full_messages
        end
      end



    end
  end
end