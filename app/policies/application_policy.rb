class ApplicationPolicy
  attr_reader :user, :flight

  def initialize(user, flight)
    raise Pundit::NotAuthorizedError, "¡Debes de estar logueado!" unless user
    @user = user
    @flight = flight
  end

  def index?
    false
  end

  def show?
    scope.where(:id => flight.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, flight.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
