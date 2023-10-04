class Ability
  include CanCan::Ability
  def initialize(current_user)
    @user = current_user || User.new
    if @user.role == 'admin'
      can :delete, Comment
      can :destroy, Comment
      can :delete, Post
      can :destroy, Post
      can :create, Post

    end
    can :destroy, Comment, author_id: @user.id
    can :delete, Comment, author_id: @user.id
    can :destroy, Post, author_id: @user.id
    can :delete, Post, author_id: @user.id
    can :create, Post, author_id: @user.id
    can :read, Post
    can :create, Comment
  end
end
