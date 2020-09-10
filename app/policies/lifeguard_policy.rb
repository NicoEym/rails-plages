class LifeguardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # only an admin or the propriate user can create a lifeguard profile
    user_profile_or_user_is_admin?
  end

  def index?
    # everyone can see all the profiles
    true
  end

  def update?
    # only an admin or the propriate user can update a lifeguard profile
    user_profile_or_user_is_admin?
  end

  def show?
    # everyone can see a lifeguard profile
    true
  end

  def destroy?
    # only an admin or the propriate user can destroy a lifeguard profile
    user_profile_or_user_is_admin?
  end

  private

  def user_is_admin?
    @record.user.admin?
  end

  def user_profile_or_user_is_admin?
     user_is_admin? || @record.user == user
  end
end
