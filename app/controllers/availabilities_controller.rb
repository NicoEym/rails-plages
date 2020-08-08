class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  # def new
  #   @user = current_user
  #   @season = @user.season
  #   @calendars = @season.calendars
  #   number_of_days = @calendars.all.count
  #     @user_availabilities = number_of_days.times {@user.availabilities.build(user: @user)}

  #   authorize @user_availabilities
  # end

  # def create
  #   @availability = Availability.new(availability_params)
  #   authorize @availability
  #   if @availability.save
  #     redirect_to season_path(@availability)
  #   else
  #     render :new
  #   end
  # end

  # def index
  #   @availabilities = policy_scope(Availability)
  # end

  # def show
  # end

  # def edit
  # end

  # def update
  #   if @availability.update(beach_params)
  #     redirect_to availability_path(@availability)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @availability.destroy
  #   redirect_to availabilities_path
  # end

  # private

  # def set_availability
  #   @availability = Availability.find(params[:id])
  #   authorize @availability
  # end

  # def availability_params
  #   params.require(:availability).permit(:user, :calendar, :available)
  # end
end
