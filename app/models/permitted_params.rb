# class is instantiated in Application Controller
#   params, current_user
class PermittedParams < Struct.new(:params, :user)

  # return a filtered version of the params
  def filter_for ownable
    # get the class name of the ownable
    class_name          = ownable.class_name_to_sym.to_s
    
    # make sure params format is as follows:
    #   { ownable_class_name: {param1: :value, param2: :value} }
    ownable_params      = params.required(class_name)
    return {} if !ownable_params

    # get a list of attributes that are allowed for this item
    #   could be true, false, or an array of allowed attributes
    allowed_attributes  = attributes_for(ownable)

    # decide how to handle the received attributes
    if allowed_attributes == true
      # allow all
      ownable_params    = ownable_params.permit!
    elsif allowed_attributes == false
      # allow none
      ownable_params    = ownable_params.permit *[]
    end
    # filter out everything except allowed_attributes
    ownable_params      = ownable_params.permit *allowed_attributes
  end

  # get a list of attributes that user can access of an ownable
  def attributes_for attrs_for=@ownable
    if attrs_for.is_a? Ownable
      # 
      ownable = @ownable = attrs_for
      @ownable      = ownable
      #@user_type    = @ownable.ownerable_type_of user
      class_name    = @ownable.class_name_to_sym.to_s
      self.send("#{class_name}_attributes")
    elsif attrs_for.is_a? Class
      # get attributes for of class name
    else
      # convert to symbol
      #attrs_for = 
    end
  end

  def self.define_model_rule  (modelname, &block)
    define_method "#{modelname}_attributes" do
      block.call @ownable, user
    end
  end


end