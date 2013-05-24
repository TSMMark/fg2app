class Api::BaseController < ApplicationController
  respond_to :json
  before_filter :get_params
  before_filter :set_table
  before_filter :find_by_id, :only => [:show, :edit, :update, :destroy]

  # API methods
  def index
    respond_with @table.all
  end

  def show
    respond_with @object
    #@user = User.find(params[:id])
    #ages = @user.fetch_pages
    #raise pages.to_yaml
  end

  def create
    respond_with @table.create(params[@object_param])
  end

  def update
    respond_with @object.update_attributes(params[@object_param])
  end

  def destroy
    respond_with @object.destroy
  end

  # protected methods / filters etc
  protected

    def find_by_id
      @object = @table.find(params[:id])
    end

    def respond_with obj
      #raise @options.to_yaml
      super obj, @options
    end

    def get_params
      @options  = {only: []}
      params.each do |key,val|
        case key
        when 'fields', :fields
          # only return the fields specified in URL (split by comma)
          # always include id
          @options[:only] = (val.split(/,/).collect(&:strip) << :id)
        end
      end
      @options.delete :only if @options[:only].empty?
    end
end
