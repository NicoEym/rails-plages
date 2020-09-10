class BeachPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # a user can see all the beaches
      @scope.all
    end
  end

  def create?
    # only the admin can create a new beach
    user_is_admin?
  end

  def show?
    # a user can see any beach
    true
  end

  def update?
    # only the admin can update a new beach
    user_is_admin?
  end

  def destroy?
    # only the admin can destroy a new beach
    user_is_admin?
  end

  private

  def user_is_admin?
    @user.admin?
  end
end
