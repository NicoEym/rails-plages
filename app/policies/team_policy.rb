class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
        @scope.where(user: @user)
      @teams = []
      if @user.head?
        plannings = HeadLifeguard.where(user: @user)
        plannings.each do |planning|
          @teams << planning.team
        end
      else
        plannings = HeadLifeguard.where(user: @user)
         plannings.each do |planning|
          @teams << planning.team
        end
      end
      @teams
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
