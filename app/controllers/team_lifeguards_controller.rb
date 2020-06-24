class TeamLifeguardsController < ApplicationController
  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.find(params[:team_id])
    @team_lifeguard = TeamLifeguard.new
    @leader = Rank.find_by(name: "Chef de poste")
    @team_mate = Rank.find_by(name: "Equipier")
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def create
    @team_lifeguard = TeamLifeguard.new(team_lifeguard_params)
    @team_lifeguard.team = Team.find(params[:team_id])
    @date = @team_lifeguard.team.calendar
    @team_lifeguard.save
    if @team_lifeguard.save
      # redirect_to calendar_path(@date.id)
    else
      render :new
    end
  end

  def edit
    # @date = Calendar.find(params[:calendar_id])
    # @beach = Beach.find(params[:beach_id])
    # @team = Team.find(params[:team_id])
    # @leader = Rank.find_by(name: "Chef de poste")
    # @team_mate = Rank.find_by(name: "Equipier")
    # @team_mate_number = @beach.number_of_team_members - 1
    # team_lifeguards = TeamLifeguard.new
  end

  private

  def team_lifeguard_params
    params.require(:team_lifeguard).permit(:team_id, :user_id)
  end
end
