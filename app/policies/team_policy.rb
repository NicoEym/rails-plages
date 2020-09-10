class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # @scope.with(@user)
      # a user lifeguard can only see the team he is in
      @user.lifeguard.teams
    end
  end

  def create?
    # only an admin can update a team
    user_is_admin?
  end

  def update?
    # only an admin can update a team
    user_is_admin?
  end

  def destroy?
    # only an admin can destroy a team
    user_is_admin?
  end

  private

  def user_is_admin?
    @user.admin?
  end
end
