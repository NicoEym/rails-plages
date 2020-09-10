class UsersController < ApplicationController
  def show
    # we define the user
    @user = User.find(params[:id])
    authorize @user

    # we initiate the lifeguard profile...
    @lifeguard = @user.lifeguard
    @lifeguard = Lifeguard.new(user: @user) if @lifeguard.nil?

    # ... and the availabilites
    @availabilities = @lifeguard.availabilities unless @lifeguard.availabilities.nil?
  end
end
