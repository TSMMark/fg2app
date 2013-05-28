module DoesApi


  #    ClassMethod Stuff    #
  extend ActiveSupport::Concern
  included do
    scope :disabled, where(:disabled => true)
  end
  #    ClassMethods    #
  module ClassMethods
    # define an API scope of :name which grants :fields
    def define_api (names, fields)
      names = [names] unless names.is_a? Array
      names.each do |n|
        api_accessible n.to_sym do |t|
          fields.each do |field|
            t.add field
          end
        end
      end
    end



  end
  # .. ClassMethods .. #


end