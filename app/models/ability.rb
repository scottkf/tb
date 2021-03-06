class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user
 
    if user.role? :super_admin
      can :see_timestamps, User
      can :manage, :all
    elsif user.role? :editor
      can :read, Article
      # manage articles he owns
      can :create, Article
      can :manage, Article, :user_id => user.id
      # can manage his account
      can :manage, User, :id => user.id
      can :see_timestamps, User, :id => user.id
      # can manage, but not delete categories
      can [:read, :create, :update], Category
    elsif user.role? :regular
      can :read, Article
      can [:index, :list], Category
      can :manage, User, :id => user.id
    else
      can :read, Article
      can [:index, :list], Category
    end
  end
end