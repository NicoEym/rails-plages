class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    @lifeguard = @user.lifeguard
    @lifeguard = Lifeguard.new(user: @user) if @lifeguard.nil?
  end
end
