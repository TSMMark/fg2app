module Api
  module V1
    class PagesController < Api::BaseController
      
      def initialize
        self.set_table :page
      end



    end


  end
end