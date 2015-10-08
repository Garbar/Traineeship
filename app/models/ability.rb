class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can [:read, :create, :make_pro, :see_shop], Product
    elsif user.customer?
      can [:read, :create, :see_shop], Product
    elsif user.user?
      can :read, :all
      can :purchase, Product, pro: false
    else
      can :read, Product, pro: false
    end
  end
end
