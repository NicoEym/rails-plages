class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  def new
    @season = Season.new
  end

  def create
    @season = Season.new(season_params)
    authorize @season
    if @season.save
      for day in start_date..end_date
        new_date = Calendar.new(day: day, season: @season)
        new_date.save
      end
      redirect_to season_path(@season)
    else
      render :new
    end
  end

  def index
    @seasons = policy_scope(Season)
  end

  def show
    @dates = @season.calendars
  end

  def edit
  end

  def update
    if @season.update(season_params)

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
