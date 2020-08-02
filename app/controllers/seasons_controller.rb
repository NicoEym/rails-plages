class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy]

  def new
    @season = Season.new
  end

  def create
    @season = Beach.new(season_params)
    authorize @season
    if @season.save
      redirect_to season_path(@season)
    else
      render :new
    end
  end

  def index
    @seasons = policy_scope(Season)
  end

  def show
  end

  def edit
  end

  def update
    if @season.update(beach_params)
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

  def set_beach
    @season = Season.find(params[:id])
    authorize @season
  end

  def season_params
    params.require(:season).permit(:name, :address, :latitude, :longitude, :number_of_team_members,:photo_url)
  end
end
