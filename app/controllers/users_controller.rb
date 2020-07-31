class UsersController < ApplicationController
  before_action :set_lifeguard, only: [:show, :edit, :update, :destroy]

  def index
    # will get all the lifeguards except the admins
    @lifeguards = policy_scope(User)
    authorize @lifeguards
  end

  def show
  end

  def edit
  end

  def update
    if @lifeguard.update(lifeguard_params)
      redirect_to user_path(@lifeguard)
    else
      render :edit
    end
  end

  def destroy
    # !!!!!!!!!!! need to review this
    # we delete the user
    @lifeguard.destroy
    # if the admin is performing the action, we go back to the user index
    if current_user.admin?
      redirect_to users_path
    else
      # if the user is deleting his own session we go back to the main page
      redirect_to root_path
    end
  end

  private

  def set_lifeguard
    @lifeguard = User.find(params[:id])
    authorize @lifeguard
  end

  def lifeguard_params
    params.require(:user).permit(:firstname, :lastname, :mobile, :photo, :bnssa, :pse1, :pse2)
  end
end
