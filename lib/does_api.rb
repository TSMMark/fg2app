module DoesApi


  #    ClassMethod Stuff    #
  extend ActiveSupport::Concern
  included do
    scope :disabled, where(:disabled => true)
  end
  #    ClassMethods    #
  module ClassMethods
    @@param_sets = {}

    def params (name)
      @@param_sets[name]
    end

    def define_param_set (scopes, accessible_params)
      scopes = scopes.make_array
      scopes.each do |n|
        @@param_sets[n] = accessible_params
      end
      accessible_params
    end

    # define an API scope of :name which grants :accessible_params
    def define_api (scopes, accessible_params)
      scopes   = scopes.make_array
      define_param_set scopes, accessible_params

      # for each name in the list
      scopes.each do |n|
        # create a new API rule with each param
        api_accessible n.to_sym do |t|
          # add each param 
          accessible_params.each do |param|
            t.add param
          end
        end
      end
    end

  end
  # .. ClassMethods .. #

  # get Array of params in a scope
  def params (name)
    self.class.params name
  end



end