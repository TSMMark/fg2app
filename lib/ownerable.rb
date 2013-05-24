module Ownerable

  # user type relative to an object
  def user_type obj
    obj.requesting_user_type self
  end

  def ownerable?
    true
  end

  def is_owner_of? ownableAsset
    self.owner_of ownableAsset
  end
  def owner_of? ownableAsset
    return true unless ownableAsset.is_a? Ownable
    ownableAsset.user_is_owner? self
  end

  def can_create? ownableAsset
    return true unless ownableAsset.is_a? Ownable
    ownableAsset.user_can_create? self
  end

  def can_read? ownableAsset
    return true unless ownableAsset.is_a? Ownable
    ownableAsset.user_can_read? self
  end

  def can_update? ownableAsset
    return true unless ownableAsset.is_a? Ownable
    ownableAsset.user_can_update? self
  end

  def can_destroy? ownableAsset
    return true unless ownableAsset.is_a? Ownable
    ownableAsset.user_can_destroy? self
  end

end