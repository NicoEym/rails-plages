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
      for day in @season.start_date..@season.end_date
        Calendar.create(day: day, season: @season) if Calendar.find_by(day: day, season: @season).nil?
      end
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

  def set_season
    @season = Season.find(params[:id])
    authorize @season
  end

  def season_params
    params.require(:season).permit(:name, :start_date, :end_date)
  end
end
