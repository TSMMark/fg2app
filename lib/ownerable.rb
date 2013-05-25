module Ownerable
  
  # protected_active_record stuff
  def read_attributes ownable
    ownable.read_attributes self
  end


  # user type relative to an object
  def user_type obj
    obj.requesting_user_type self
  end

  def ownerable?
    true
  end

  def is_owner_of? ownable
    self.owner_of ownable
  end
  def owner_of? ownable
    return true unless ownable.is_a? Ownable
    ownable.user_is_owner? self
  end

  def can_create? ownable
    return true unless ownable.is_a? Ownable
    ownable.user_can_create? self
  end

  def can_read? ownable
    return true unless ownable.is_a? Ownable
    ownable.user_can_read? self
  end

  def can_update? ownable
    return true unless ownable.is_a? Ownable
    ownable.user_can_update? self
  end

  def can_destroy? ownable
    return true unless ownable.is_a? Ownable
    ownable.user_can_destroy? self
  end

end