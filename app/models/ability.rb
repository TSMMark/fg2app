class Ability
  include CanCan::Ability

  # unneeded; just make everyone a guest
  # def user_signed_in
  #   @user
  # end

  def initialize user
    # make guest user if no user
    @user = user
    @user ||= User.new_guest

    # FOR TESTING
    # @user.admin=true
    # puts "USER!"
    # puts @user.to_yaml

    if @user.admin?
      # can :create, :all
      # can :read, :all
      can :manage, :all
    else 
      #unless @user.guest?
      #end

      if_owner_or_admin = Proc.new { |ownable|
        cannn = ownable.try(:ownerable_is_admin_or_owner?, @user)
      }

      #    TABS    #
      # can update if admin or owner
      # can :manage, Tab, user: { id: user.id }
      can :manage, Tab, users: { id: user.id }
      can :create, Tab, users: { id: user.id }
      # can :read, Tab, &if_owner_or_admin
      # can :create, Tab, &if_owner_or_admin
      # .. TABS .. #


      #    USERS    #
      # can update if admin or owner
      can :manage, User, id: user.id
      # can :read, User, &if_owner_or_admin
      # can :update, User, &if_owner_or_admin
      # .. USERS .. #



      #    PAGES    #
      # can update if admin or owner
      can :manage, Page, users: { id: user.id }
      # can :read, Page, &if_owner_or_admin
      # .. PAGES .. #



      #    PAGETOKENS    #
      can :manage, Pagetoken, user: { id: user.id }
      # .. PAGETOKENS .. #


    end

  end
end