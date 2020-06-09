class CalendarsController < ApplicationController


  def index
    @dates = Calendar.all
  end

  def show
    @date = Calendar.find(params[:id])
    @beaches = Beach.all
    @teams = Team.find_by(calendar: @date)
  end

end
