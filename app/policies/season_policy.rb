class SeasonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @scope.all
    end
  end

  def create?
    # only an admin can create a new season
    user_is_admin?
  end

  def show?
    # only an admin can see a season
    user_is_admin?
  end

  def update?
    # only an admin can update a season
    user_is_admin?
  end

  def destroy?
    # only an admin can destroy a season
    user_is_admin?
  end

  private

  def user_is_admin?
    @user.admin?
  end
end
