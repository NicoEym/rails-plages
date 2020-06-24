class TeamsController < ApplicationController

  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.new
    # @leader = Rank.find_by(name: "Chef de poste")
    # @team_mate = Rank.find_by(name: "Equipier")
    # @team_mate_number = @beach.number_of_team_members - 1
  end

  def create
    @team = Team.new(team_params)
    @team.calendar = Calendar.find(params[:calendar_id])
    @team.beach = Beach.find(params[:beach_id])
    if @team.save
      redirect_to new_calendar_beach_team_team_lifeguard_path(@team.calendar, @team.beach, @team)
    else
      render :home
    end
  end

  def destroy
    @team = Team.find(params[:id])
    date = @team.calendar
    @team.destroy
    redirect_to calendar_path(date.id)
  end

  private

  def team_params
    params.permit(:calendar_id, :beach_id)
  end
end
