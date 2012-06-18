class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    
    can :read, :all

    if user.persisted?
      can :create, Post

      can :manage, Post, :user_id => user.id
     
      can :create, Comment

      can :manage, Comment, :user_id => user.id

      can :edit, User, :id => user.id
    end

    if user.admin?
      can :manage, :all
    end     
 
  end
end
