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
    user_profile_or_user_is_admin?
  end

  def show?
    true
  end

  def destroy?
    user_profile_or_user_is_admin?
  end

  private

  def user_is_admin?
    @user.admin?
  end

  def user_profile_or_user_is_admin?
    @user.admin? || @record == user
  end
end
