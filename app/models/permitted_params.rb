# class is instantiated in Application Controller
#   params, current_user
class PermittedParams < Struct.new(:params, :user)
  def params_for ownable
    params.require(:tab).permit *tab_attributes
  end

  def tab
    params.require(:tab).permit *tab_attributes
  end

  def tab_attributes
    if user && user.admin?
      [:name, :fbapp_id]
    else
      [:name, :description]
    end
  end

  def tab_conditions
  end
  
end