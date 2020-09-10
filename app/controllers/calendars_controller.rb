class CalendarsController < ApplicationController
  def index
    # we  authorize the dates in the index
    @dates = policy_scope(Calendar)
    authorize @dates
  end

  def show
    # we define the variables
    @season = Season.find(params[:season_id])
    @date = Calendar.find(params[:id])
    # we authorize
    authorize @date

    # we select all the beaches by location
    @beaches = Beach.all.order('longitude desc')
    # we select all the existing teams on this date
    @teams = Team.find_by(calendar: @date)
  end
end
