class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Asset, user_id: user.id
    can :read, :all
  end
end
