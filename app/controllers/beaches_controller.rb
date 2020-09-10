class BeachesController < ApplicationController
  # we set the beach using a private method in case we are doing show, edit, update, destroy
  before_action :set_beach, only: [:show, :edit, :update, :destroy]

  def new
    # We create a new beach and check if the user is authorized
    @beach = Beach.new
    authorize @beach
  end

  def create
    # We create a new beach and check if the user is authorized
    @beach = Beach.new(beach_params)
    authorize @beach
    # we save or redirect to new
    if @beach.save
      redirect_to beach_path(@beach)
    else
      render :new
    end
  end

  def show
    # we set the markers for this beach
     @markers = [{
        lat: @beach.latitude,
        lng: @beach.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { name: @beach.name, city: @beach.address })
      }]
  end

  def index
    # checking the authorization
    @beaches = policy_scope(Beach)
    # we create a new beach to give the option to the user
    @beach = Beach.new
    # we set the markers for all the beaches
    @markers = @beaches.map do |beach|
      {
        lat: beach.latitude,
        lng: beach.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { name: beach.name, city: beach.address })
      }
    end
  end

  def edit
    # done in the private method set_beach
  end

  def update
    # we update and redirect or we will render the edit page
    if @beach.update(beach_params)
      redirect_to beach_path(@beach)
    else
      render :edit
    end
  end

  def destroy
    # we destroy the beach redirect to the beach index
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
