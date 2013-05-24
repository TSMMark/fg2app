module Api
  module V1
    class UsersController < Api::BaseController
      class User < ::User
        def as_json(options=nil)
          options = @options if !options
          #raise options.to_yaml
          #super.except(:last_page_fetch)
          #super(options).merge(api_v: 1)
          super(options)
          #super.attributes.slice(:last_page_fetch)
        end
      end

      def me
        if user_signed_in? then
          respond_with @table.find(current_user)
        else
          respond_with RequestError.new 403
        end
      end

      protected
      def set_table
        # ActiveModel Class of this Controller
        @table = User

        # the parameter that will contain the object in an update or create request
        @object_param = :user
      end

    end





  end
end