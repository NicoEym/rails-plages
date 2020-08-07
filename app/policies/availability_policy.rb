class AvailabilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: @user)
    end
  end

  def create?
    user_profile_or_user_is_admin?
  end

  def index?
    user_profile_or_user_is_admin?
  end

  def update?
    user_profile_or_user_is_admin?
  end

  def show?
    user_profile_or_user_is_admin?
  end

  def destroy?
    user_profile_or_user_is_admin?
  end

  private

  def user_profile_or_user_is_admin?
    @user.admin? || @record.user == user
  end
end
