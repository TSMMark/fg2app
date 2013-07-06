module Api
  module V1
    class LayoutsController < Api::V1::BaseController #Api::BaseController

      # cancan
      load_and_authorize_resource :layout, through: :current_user, except: :create

      # cancan strong parameters
      # permit_params :name, :page_id

      # API methods
      def index
        respond_with @layouts
      end

      def show
        respond_with @layout
      end

      def create
        @layout = Layout.new(params[:layout])
        authorize! :create, @layout

        if @layout.save
          # make current_user an editor of this layout
          # TODO set editor types
          current_user.become_editor_of @layout do |le|
            le.active = true
            le.save!
          end
          
          respond_with @layout
        else
          # respond_with_error @layout.errors.full_messages
          respond_with @layout, status: :unprocessable_entity
        end
      end

      def update
        if @layout.update_attributes(params[:layout])
          respond_with @layout
        else
          # respond_with_error @layout.errors.full_messages
          respond_with @layout, status: :unprocessable_entity
        end
      end

      def destroy
        if @layout.destroy
          respond_with_success "deleted layout with id: #{@layout.id}"
        else
          # respond_with_error @layout.errors.full_messages
          respond_with @layout, status: :unprocessable_entity
        end
      end


    end
  end
end