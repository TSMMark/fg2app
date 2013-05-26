module Ownerable
  
  # protected_active_record stuff
  def read_attributes ownable
    ownable.read_attributes self
  end


  # ownerable type relative to an object
  def ownerable_type ownable
    ownable.ownerable_type_of self
  end

  def ownerable?
    true
  end

  # is self an owner of an ownable?
  def owner_of? ownable
    return true unless ownable.is_a? Ownable
    ownable.ownerable_is_owner? self
  end
  # alias of owner_of
  def is_owner_of? ownable
    self.owner_of ownable
  end

  def can_create? ownable
    return true unless ownable.is_a? Ownable
    ownable.ownerable_can_create? self
  end

  def can_read? ownable
    return true unless ownable.is_a? Ownable
    ownable.ownerable_can_read? self
  end

  def can_update? ownable
    return true unless ownable.is_a? Ownable
    ownable.ownerable_can_update? self
  end

  def can_destroy? ownable
    return true unless ownable.is_a? Ownable
    ownable.ownerable_can_destroy? self
  end

end