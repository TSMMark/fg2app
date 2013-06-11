module DoesApi


  #    ClassMethod Stuff    #
  extend ActiveSupport::Concern
  included do
    scope :disabled, where(:disabled => true)
    # scope :owned_by, ->(ownerable) {where(:user => ownerable)}
  end
  
  #    ClassMethods    #
  module ClassMethods
    def define_param_rules &rules
      model_name        = name_to_sym
      PermittedParams.define_model_rule model_name do |ownable, ownerable|
        allowed_params  = rules.call ownable, ownerable
        # create API set for allowed_params
      end
    end

  end
  # .. ClassMethods .. #


  # filter attributes according to permitted_params rules
  def filter_params ownerable
    params           = ActionController::Parameters.new(self.class.name_to_sym => self.attributes)
    permitted_params = PermittedParams.new(params, ownerable)
    permitted_params.filter_for self
  end


end