class FlightPolicy < ApplicationPolicy
  attr_reader :user, :flight

  def index?
    true
  end

  def show?
    scope.where(:id => flight.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    scope.where(user_id: user.id).exists? and (user.admin? or user == flight.user)
  end

  def edit?
    update?
  end

  def destroy?
    scope.where(user_id: user.id).exists? and (user.admin? or user == flight.user)
  end
end
