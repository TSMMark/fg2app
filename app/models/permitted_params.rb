# class is instantiated in Application Controller
#   params, current_user
class PermittedParams < Struct.new(:params, :user)
  def ownable ownable, params=nil
    params.require(:tab).permit *tab_attributes
  end

  def tab object=nil
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