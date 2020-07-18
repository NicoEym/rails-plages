class BeachesController < ApplicationController
  before_action :set_beach, only: [:show, :edit, :update, :destroy]

  def new
    @beach = Beach.new
  end

  def create
  end

  def show
  end

  def index
    @beaches = policy_scope(Beach)
  end

  def edit
  end

  def update
  end

  def destroy
    @beach.destroy
    redirect_to calendar_path(date.id)
  end

  private

  def set_beach
    @beach = Beach.find(params[:id])
    authorize @beach
  end
end
