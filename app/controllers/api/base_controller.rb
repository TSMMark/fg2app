class Api::BaseController < ApplicationController
  #include ActionView::Helpers::TextHelper
  
  # rescue_from CanCan::AccessDenied do |exception|
  #   error = {:errors => {:name => 'Access Denied'}}
  #   # exception.ryaml
  #   # error = {:errors => exception.default_message}
  #   respond_with error, :status => 422
  # end
  
  respond_to :json
  #before_filter :find_by_id, only: [:show, :update, :destroy]

  def set_table table
    @object_param  = table
    @table         = table.constantize
  end

  # API methods
  def index
    api_render(@table.all)
  end

  # def show
  #   api_render(@object, @object.ownerable_type_of(current_user))

  #   # respond_with @object
  #   # @user = User.find(params[:id])
  #   # ages = @user.fetch_pages
  #   # raise pages.to_yaml
  # end

  # def create
  #   respond_with @table.create(params[@object_param])
  # end

  # def update
  #   respond_with @object.update_attributes(params[@object_param])
  #   # might have to @object.save! here
  # end

  # def destroy
  #   respond_with @object.destroy
  # end

  # protected methods
  protected
  def decide_fields
    fields = @object.readable current_user
    fields = @object.attributes.keys if fields == true
  end

  def api_render(object, view=nil)
    view ||= :public
    render_for_api view, json: object, root: @object_param
  end
  # override "acts_as_api"s render_for_api method
  # def render_for_api resource, fields=nil
  #   fields ||= decide_fields
  #   @@table.define_api :api_resource, fields
  #   super :api_resource, :json => resource, :root => @@object_param
  # end

  # def find_by_id
  #   @object = @table.find(params[:id])
  # end

  def respond_with *params
    super *params # obj, @options
  end

end
