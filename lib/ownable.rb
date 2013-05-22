module Ownable

  def ownable?
    true
  end

  def get_owners
    self.users
  end

  def owners
    self.get_owners
  end

  def get_owner
    self.get_owners.last
  end
  def owner
    self.get_owner
  end

  def user_is_owner? user=current_user
    self.get_owners.include? user
  end

  # returns true if a user is an OWNER or an ADMIN
  def user_is_admin_or_owner? user=current_user
    user.admin? || self.user_is_owner?(user)
  end

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