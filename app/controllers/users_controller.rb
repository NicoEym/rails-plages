class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    @lifeguard = Lifeguard.new(user: @user)
  end
end
