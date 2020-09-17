class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  def new
    # we create and authorize the new season
    @season = Season.new
    authorize @season
  end

  def create
    # we create a new season using the parameters
    @season = Season.new(season_params)
    authorize @season
    if @season.save
      # for each date between the start date and the end date we are creating a Calendar object (a Date)
      for day in @season.start_date..@season.end_date
        new_date = Calendar.new(day: day, season: @season)
        new_date.save
      end
      redirect_to season_path(@season)
    else
      render :new
    end
  end

  def index
    # we display all the season
    @seasons = policy_scope(Season)
    @season = Season.new
  end

  def show
    # we show all the dates in the season
    @dates = @season.calendars
  end

  def edit
  end

  def update
    if @season.update(season_params)
      # first we will delete all the dates that not longer belong to the season
      delete_season_days
      # then we will create all the new dates
      create_new_season_days
      redirect_to season_path(@season)
    else
      render :edit
    end
  end

  def destroy
    @season.destroy
    redirect_to seasons_path
  end

  private

  def delete_season_days
    all_season_dates = @season.calendars
    all_season_dates.each do |date|
      date.destroy if date.day < @season.start_date || date.day > @season.end_date
    end
  end

  def create_new_season_days
    for day in @season.start_date..@season.end_date
        Calendar.create(day: day, season: @season) if Calendar.find_by(day: day, season: @season).nil?
    end
  end

  def set_season
    @season = Season.find(params[:id])
    authorize @season
  end

  def season_params
    params.require(:season).permit(:name, :start_date, :end_date)
  end
end
