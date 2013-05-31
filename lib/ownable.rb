module Ownable

  #@@get_owners_proc  = Proc.new{|ownable| ownable.users}

  # REQUEST field list based on the requesting ownerable
  def ownerable_type_of ownerable=nil
    if(ownerable) then
      return :owner if ownerable.owner_of? self
      return :admin if ownerable.admin?
      return :guest if ownerable.guest?
    end
    :public
  end

  # permission methods
  def ownable?
    true
  end
  def owner
    self.owners.first
  end
  def owners
    self.users
  end

  # return true if an Ownerable is an owner of this Ownable
  #   OR if this Ownable is not persisted, so anyone can access new Models
  def ownerable_is_owner? ownerable
    (!self.persisted?) || (self.owners.include? ownerable)
  end

  # returns true if a ownerable is an OWNER or an ADMIN of the Ownable
  def ownerable_is_admin_or_owner? ownerable
    ownerable.try(:admin?) || self.ownerable_is_owner?(ownerable)
  end




  # CRUD permissions.
  #   Not in use because we switched to CanCan
  # 
  # def ownerable_can_create? ownerable
  #   ownerable_is_admin_or_owner? ownerable
  # end
  # def ownerable_can_read? ownerable
  #   ownerable_is_admin_or_owner? ownerable
  # end
  # def ownerable_can_update? ownerable
  #   ownerable_is_admin_or_owner? ownerable
  # end
  # def ownerable_can_destroy? ownerable
  #   ownerable_is_admin_or_owner? ownerable
  # end

end