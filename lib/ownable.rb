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
  # alias ownable?
  def is_ownable?
    ownable?
  end
  
  def owners
    self.users
  end
  def owner
    self.owners.first
  end

  # return true if an Ownerable is an owner of this Ownable
  #   OR if this Ownable is not persisted, so anyone can access new Models
  def ownerable_is_owner? ownerable, or_admin=false
    return ownerable_is_admin_or_owner? if or_admin

    # if the tab doesn't have an owner and isn't saved yet
    #   (should work fine without the persisted check)
    !!(self.owners.make_array.empty? ||
        # OR if ownerable is listed as an owner
        self.owners.make_array.include?(ownerable)
        # (self.owners.make_array.detect {|o| o == ownerable})
      )
  end

  # returns true if a ownerable is an OWNER or an ADMIN of the Ownable
  def ownerable_is_admin_or_owner? ownerable
    !!(ownerable.try(:admin?) || self.ownerable_is_owner?(ownerable, false))
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