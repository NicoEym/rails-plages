class LifeguardsController < ApplicationController
  before_action :set_lifeguard, only: [:edit, :update, :destroy]

  def new
    # we define the variables in a private method
    set_variables
    # we initiate our new lifeguard
    @lifeguard = Lifeguard.new(user: @user, season: @season)
    authorize @lifeguard
    # with all the possible availabilities
    @calendars.each do |calendar|
      @lifeguard.availabilities.build(calendar: calendar)
    end
  end

  def create
    # we create and authorize our lifeguards
    @lifeguard = Lifeguard.new(lifeguard_params)
    authorize @lifeguard
    # we set the season and the user as they do not come with the params
    @lifeguard.season = Season.find(lifeguard_params[:season_id])
    @lifeguard.user = User.find(params[:user_id])

    # we save
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

  def edit
     # we define the variables in a private method
    set_variables
    # we redefine the season
    @season = @lifeguard.season

    # all the availabilities
    @lifeguard.availabilities = @lifeguard.availabilities.order('calendar_id asc')
  end

  def update
    if @lifeguard.update(lifeguard_params)
      redirect_to user_path(@user)
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

  def set_variables
    @user = User.find(params[:user_id])
    @season = Season.first
    @calendars = @season.calendars
    @number_of_days = @calendars.all.count - 1
  end

  def set_lifeguard
    @lifeguard = Lifeguard.find(params[:id])
    @user = @lifeguard.user
    authorize @lifeguard
  end

  def lifeguard_params
    params.require(:lifeguard).permit(:bnssa, :pse1, :pse2, :user_id, :season_id, availabilities_attributes: [:id, :calendar_id, :available, :_destroy])
  end
end
