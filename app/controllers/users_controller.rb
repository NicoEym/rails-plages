class UsersController < ApplicationController
  def index
    @lifeguards = policy_scope(User)
    authorize @lifeguards
  end

  def show
    @lifeguard = User.find(params[:id])
    authorize @lifeguard
  end
end
