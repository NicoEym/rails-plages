class UsersController < ApplicationController
  def index
    @lifeguards = User.all
  end

  def show
    @lifeguard = User.find(params[:id])
  end
end
