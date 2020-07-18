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
  end

  def index
    @beaches = policy_scope(Beach)
    @beach = Beach.new
  end

  def edit
  end

  def update
    redirect_to beach_path(@beach)
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
end
