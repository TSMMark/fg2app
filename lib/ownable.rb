module Ownable

  # REQUEST field list based on the requesting user
  def requesting_user_type user=nil
    return :public if(!user)
    return :admin if user.admin?
    return :owner if user.owner_of? self
  end

  # DEFINE FIELD PERMISSIONS (which fields can be accessed via API)
  def fields_for user_type
    self.send "fields_for_#{user_type}"
  end
  def fields_for_admin
    true
  end
  def fields_for_owner
    true
  end
  def fields_for_public
    true
  end

  # permission methods
  def ownable?
    true
  end

  # get array of owners
  def get_owners
    self.users
  end
  # get last owner
  def get_owner
    self.get_owners.last
  end

  # alias get_owner
  def owner
    self.get_owner
  end
  # alias get_owners
  def owners
    self.get_owners
  end

  # return true if a user is an owner of the Ownable
  def user_is_owner? user=current_user
    self.get_owners.include? user
  end

  # returns true if a user is an OWNER or an ADMIN of the Ownable
  def user_is_admin_or_owner? user=current_user
    user.admin? || self.user_is_owner?(user)
  end

  # CRUD permissions
  def user_can_create? user=current_user
    user_is_admin_or_owner? user
  end
  def user_can_read? user=current_user
    user_is_admin_or_owner? user
  end
  def user_can_update? user=current_user
    user_is_admin_or_owner? user
  end
  def user_can_destroy? user=current_user
    user_is_admin_or_owner? user
  end

end