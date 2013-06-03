class Api::BaseController < ApplicationController
  #include ActionView::Helpers::TextHelper
  
  rescue_from CanCan::AccessDenied do |exception|
    # error = {:errors => {:name => 'Access Denied'}}
    # exception.ryaml
    error = {:error => exception.message}
    respond_with error, :status => 422
  end
  
  respond_to :json
  #before_filter :find_by_id, only: [:show, :update, :destroy]

  # def set_table table
  #   @object_param  = table
  #   @table         = table.constantize
  # end

  # # API methods
  # def index
  #   api_render(@table.all)
  # end

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


  # get the ActiveModel of this API page
  def api_model
    api_model_nane.constantize
  end
  # get the string name of the ActiveModel of this API page
  def api_model_nane
    api_table.classify
  end
  # get table name (likely plural) of this API page
  def api_table
    controller_name
  end



  # protected methods
  protected

  # return filtered attributes of an ActiveRecord object
  def filter_record record
    okay_params         = permitted_params.attributes_for record
    record.attributes.filter_against okay_params
  end
  # def filter_params params
  #   okay_params         = permitted_params.attributes_for object
  #   object.attributes.filter_against okay_params
  # end

  # render an object or a set of objects
  #   fields that are rendered will be dependant on the permitted_params rules
  def api_render object
    # contain the object(s) in
    root  = api_table

    # if array, define rules for each item
    if object.is_a? Array then
      # define_api for the first object
      to_output = object.map do |instance|
        filtered  = filter_record instance
        # mark as nil to be removed if empty result
        !filtered || filtered.empty? ? nil : filtered
      end
      # remove nil values
      to_output.compact!
    else
      root      = root.singularize
      to_output = filter_record object
    end

    respond_with root => to_output
    #self.render_for_api       :default, json: object, root: root
    # respond_with object
  end

  # # override respond_with?
  # def respond_with *params
  #   super *params # obj, @options
  # end

end
