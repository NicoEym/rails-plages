class BeachesController < ApplicationController
  before_action :set_beach, only: [:show, :edit, :update, :destroy]

  def new
    @beach = Beach.new
    authorize @beach
  end

  def create
    @beach = Beach.new(beach_params)
    authorize @beach
    if @beach.save
      redirect_to beach_path(@beach)
    else
      render :new
    end
  end

  def show
     @markers = [{
        lat: @beach.latitude,
        lng: @beach.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { name: @beach.name, city: @beach.address })
      }]
  end

  def index
    @beaches = policy_scope(Beach)
    @beach = Beach.new

    @markers = @beaches.map do |beach|
      {
        lat: beach.latitude,
        lng: beach.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { name: beach.name, city: beach.address })
      }
    end
  end

  def edit
  end

  def update
    if @beach.update(beach_params)
      redirect_to beach_path(@beach)
    else
      render :edit
    end
  end

  def destroy
    @beach.destroy
    redirect_to beaches_path
  end

  private

  def set_beach
    @beach = Beach.find(params[:id])
    authorize @beach
  end

  def beach_params
    params.require(:beach).permit(:name, :address, :latitude, :longitude, :number_of_team_members,:photo_url)
  end
end
