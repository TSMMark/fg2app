class Ability
  include CanCan::Ability

  def initialize user
    # make guest user if no user

    user ||= User.new_guest

    # FOR TESTING
    # user.admin=true
    # puts "USER!"
    # puts user.to_yaml

    if user.admin?
      # can :create, :all
      # can :read, :all
      can :manage, :all
    else 
      #unless user.guest?
      #end

      if_owner_or_admin = Proc.new {|object|
        [:owner,:admin].include? object.try(:ownerable_type_of, user)
      }

      #    TABS    #
      can :create, Tab
      # can update if admin or owner
      can :manage, Tab, &if_owner_or_admin
      # do |object|
      #   [:owner,:admin].include? object.try(:ownerable_type_of, user)
      # end
      # .. TABS .. #


      #    USERS    #
      # can update if admin or owner
      can :read, User, &if_owner_or_admin
      # do |object|
      #   [:owner,:admin].include? object.try(:ownerable_type_of, user)
      # end
      can :update, User, &if_owner_or_admin
      # .. USERS .. #



      #    PAGES    #
      # can update if admin or owner
      can :read, Page, &if_owner_or_admin
      # .. USERS .. #


    end

  end
end