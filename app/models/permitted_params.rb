class PermittedParams < Struct.new(:params, :user)
  #def tab
  #  params.require(:tab).permit *tab_attributes
  #end
  #def tab_attributes
  #  if user && user.admin?
  #    [:name, :description]
  #  else
  #    [:name]
  #  end
  #end
end