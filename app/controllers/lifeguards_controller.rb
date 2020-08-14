class LifeguardsController < ApplicationController
  before_action :set_lifeguard, only: [:show, :edit, :update, :destroy]

  def new
    set_variables
    @lifeguard = Lifeguard.new(user: @user, season: @season)
    authorize @lifeguard
    set_availabilities

  end

  def create
    set_variables

    @lifeguard = Lifeguard.new(lifeguard_params)
    set_availabilities
    authorize @lifeguard

    if @lifeguard.save
      redirect_to user_path(@current_user)
    else
      @lifeguard.availabilities.new unless @lifeguard.availabilities.any?
      render :new
    end
  end

  def index
    # will get all the lifeguards except the admins
    @lifeguards = policy_scope(Lifeguard)
    authorize @lifeguards
  end

  def show
  end

  def edit
    @season = @lifeguard.season
    @calendars = @season.calendars
    @availabilities = @lifeguard.availabilities
    @number_of_days = @calendars.all.count - 1
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

  def set_availabilities
    @availabilities = @lifeguard.availabilities
    @calendars.each do |calendar|
      @lifeguard.availabilities.build(:lifeguard => @lifeguard, :calendar => calendar)
    end
  end

  def set_variables
    @user = User.find(params[:user_id])
    @season = Season.first
    @calendars = @season.calendars
    @number_of_days = @calendars.all.count - 1
  end

  def set_lifeguard
    @lifeguard = Lifeguard.find(params[:id])
    authorize @lifeguard
  end

  def lifeguard_params
    params.require(:lifeguard).permit(:bnssa, :pse1, :pse2, :user_id, :season_id, availabilities_attributes: [:id, :lifeguard_id, :calendar_id, :available, :_destroy])
  end
end
