class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, [User, Author, Book, Category, Publisher, RequestDetail]
      can [:read, :accept_request, :deny_request, :create], Request
      can [:edit, :update, :destroy], Request, user_id: user.id
    else
      can :read, [User, Author, Book, Category, Publisher]
      can [:update, :destroy], User, id: user.id
      can [:create, :read, :edit, :update, :destroy], Request, user_id: user.id
      can [:create, :update, :destroy], RequestDetail
      cannot :accept_request, Request
      cannot :deny_request, Request
    end
  end
end
