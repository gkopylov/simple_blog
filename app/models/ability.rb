class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    
    can :read, :all

    cannot :create, Post
    
    cannot :create, Comment

    cannot :create, Role
    
    cannot :destroy, Post
    
    cannot :destroy, Comment

    cannot :destroy, Role
    
    cannot :update, Post
    
    cannot :update, Comment

    cannot :update, Role
    
    if user.persisted?
      resources = %w(user role post comment)

      resources.each do |resource|
        can :manage, resource.classify.constantize do |item|
          user.send("manage_#{resource}?", item.id) or user.send("manage_all_#{resource.pluralize}?")
        end
      end

      can :create, Post
      
      can :manage, Post, :user_id => user.id
     
      can :create, Comment

      can :manage, Comment, :user_id => user.id

      can :edit, User, :id => user.id

      cannot :destroy, User

      cannot :create, Role
      
      cannot :update, Role
      
      cannot :destroy, Role
    end

    if user.admin?
      can :manage, :all
    end      
  end
end
