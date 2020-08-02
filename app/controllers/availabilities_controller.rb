class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def new
    @user = current_user
    @season = @user.season
    @calendars = @season.calendar.all
    @calendars.count.times { @user.availability.build }
  end

  def create
    @availability = Beach.new(availability_params)
    authorize @availability
    if @availability.save
      redirect_to season_path(@availability)
    else
      render :new
    end
  end

  def index
    @availabilities = policy_scope(Availability)
  end

  def show
  end

  def edit
  end

  def update
    if @availability.update(beach_params)
      redirect_to availability_path(@availability)
    else
      render :edit
    end
  end

  def destroy
    @availability.destroy
    redirect_to availabilities_path
  end

  private

  def set_availability
    @availability = Availability.find(params[:id])
    authorize @availability
  end

  def season_params
    params.require(:availability).permit(:user, :calendar)
  end
end
