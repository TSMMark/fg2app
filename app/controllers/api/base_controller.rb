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
      super obj, @options
    end


    # include and exclude in API calls
    # exclude_fields will be ommitted by default, but are not blacklisted
    # Move these to MODEL
    @exclude, @include, @blacklist = false
    def self.exclude_fields fields
      @exclude = fields
      #[:last_page_fetch]
    end
    # include fields must always be included
    def self.include_fields fields
      @include = fields
      #[:id]
    end
    # blacklist will NEVER be shown in API calls
    def self.blacklist_fields fields
      @blacklist = fields
      #[:updated_at, :created_at]
    end
    def exclude_fields action
      @exclude
      #[:last_page_fetch]
    end
    # include fields must always be included
    def include_fields action
      @include
      #[:id]
    end
    # blacklist will NEVER be shown in API calls
    def blacklist_fields action
      @blacklist
      #[:updated_at, :created_at]
    end

    def parse_params
      params.each do |key,val|
        case key
        when 'fields', :fields
          # only return the fields specified in URL (split by comma)
          #   strip whitespace and always include id
          @options[:only] = (val.split(/,/).collect(&:strip)) unless !val || val.empty?
        end
      end
    end

    def get_params
      #blacklist = self.blacklist_fields
      #exclude   = self.exclude_fields
      @exclude   = @exclude + @blacklist if(@blacklist.is_a?(Array) && @exclude.is_a?(Array))
      #includes  = self.include_fields
      @options  = {
        only:   [],
        except: @exclude
      }

      parse_params

      if @blacklist==true || !@options[:only]   || @options[:only].empty? then
        @options.delete :only
      else
        # include all include fields in :only
        @options[:only].push(*@includes) if @includes.is_a? Array

        # remove blacklisted items
        if @blacklist.is_a? Array then
          @options[:only] = (@options[:only].collect!(&:to_s) - @blacklist.collect!(&:to_s))
        end
      end
      @options.delete :except if !@options[:except] || @options[:except].empty?
    end
end
