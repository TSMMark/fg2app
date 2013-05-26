require 'active_support/concern'
module Ownable
  extend ActiveSupport::Concern

  included do
    scope :disabled, where(:disabled => true)
  end

  module ClassMethods
    def owners_are &block
      #raise self.to_yaml
      @@get_owners_proc = block
      #raise @@get_owners_proc.to_yaml
    end
  end

  #@@get_owners_proc  = Proc.new{|ownable| ownable.users}

  # REQUEST field list based on the requesting ownerable
  def ownerable_type_of ownerable=nil
    return :public if(!ownerable)
    return :admin if ownerable.admin?
    return :owner if ownerable.owner_of? self
    return :guest if ownerable.guest?
  end

  # DEFINE FIELD PERMISSIONS (which fields can be accessed via API)
  def fields_for ownerable_type
    self.send "fields_for_#{ownerable_type}"
  end
  def fields_for_admin
    true
  end
  def fields_for_owner
    true
  end
  def fields_for_guest
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
    #raise @@get_owners_proc.to_yaml
    @@get_owners_proc.call_or_value self
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

  # return true if a ownerable is an owner of the Ownable
  def ownerable_is_owner? ownerable
    self.get_owners.include? ownerable
  end

  # returns true if a ownerable is an OWNER or an ADMIN of the Ownable
  def ownerable_is_admin_or_owner? ownerable
    ownerable.admin? || self.ownerable_is_owner?(ownerable)
  end

  # CRUD permissions
  def ownerable_can_create? ownerable
    ownerable_is_admin_or_owner? ownerable
  end
  def ownerable_can_read? ownerable
    ownerable_is_admin_or_owner? ownerable
  end
  def ownerable_can_update? ownerable
    ownerable_is_admin_or_owner? ownerable
  end
  def ownerable_can_destroy? ownerable
    ownerable_is_admin_or_owner? ownerable
  end

end