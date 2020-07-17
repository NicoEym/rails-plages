class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_is_admin?
  end

  def update?
    user_is_admin?
  end

  def show?
    @user.admin? || @user == user
  end

  private

  def user_is_admin?
    @user.admin?
  end
end
