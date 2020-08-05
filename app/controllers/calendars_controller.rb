class CalendarsController < ApplicationController
  def index
    @dates = policy_scope(Calendar)
    authorize @dates
  end

  def show
    @season = Season.find(params[:season_id])
    @date = Calendar.find(params[:id])
    authorize @date
    @beaches = Beach.all.order('longitude desc')
    @teams = Team.find_by(calendar: @date)
  end
end
