class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      puts @scope.where(user: @user)
      @scope.with(@user)
    end
  end

  def create?
    user_is_admin?
  end

  def update?
    user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    @user.admin?
  end
end
