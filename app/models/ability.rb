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


      #    TABS    #
      can :create, Tab
      # can update if admin or owner
      can :read, Tab do |object|
        [:owner,:admin].include? object.try(:ownerable_type_of, user)
      end
      can :update, Tab do |object|
        [:owner,:admin].include? object.try(:ownerable_type_of, user)
      end
      # .. TABS .. #


      #    USERS    #
      # can update if admin or owner
      can :read, User do |object|
        [:owner,:admin].include? object.try(:ownerable_type_of, user)
      end
      can :update, User do |object|
        [:owner,:admin].include? object.try(:ownerable_type_of, user)
      end
      # .. USERS .. #



      #    PAGES    #
      # can update if admin or owner
      can :read, Page do |object|
        [:owner,:admin].include? object.try(:ownerable_type_of, user)
      end
      # .. USERS .. #


    end

  end
end