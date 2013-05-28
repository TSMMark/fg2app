module Api
  module V1
    class UsersController < Api::BaseController
      set_table :user
      
      def me
        if user_signed_in? then
          respond_with @@table.find(current_user)
        else
          respond_with RequestError.new 403
        end
      end



    end


  end
end