
class Api::BaseController < ApplicationController


  # uncomment these
  rescue_from CanCan::AccessDenied do |exception|
    respond_with_error exception.message
  end

  rescue_from ActiveModel::ForbiddenAttributes do |exception|
    respond_with_error exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    # respond_with_error exception.message, 404
    respond_with_error 'Resource not found', 404
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    respond_with_error exception.message
  end

  rescue_from ActiveModel::MassAssignmentSecurity::Error do |exception|
    respond_with_error exception.message
  end


  # skip csrf verification check
  skip_before_filter :verify_authenticity_token

  # get all objects in index
  before_filter :assign_all, only: :index

  # named_scope :owned_by, do |ownerable|
  #   { :user_id
  # end


  # attr_reader :object
  # attr_writer :object
  # attr_reader :objects
  # attr_writer :objects

  def assign_all
    @objects = api_model.all
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
  #   # pages = @user.fetch_pages
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

  def must_be_signed_in
    raise NotSignedInException unless signed_in?
  end

  def respond_with_error message="There was an error", status=422
    error = {:error => message}
    render json: error, :status => status
  end

  def respond_with_success action
    response = {message: "Successfully #{action}"}
    render json: response
  end

  ### Get Data about this model ###

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

  # 
  def get_by_id id=params[:id]
    api_model.find(id)
  end

  # moved to initializer
  # def default_serializer_options
  #   {
  #     root: false
  #   }
  # end



end