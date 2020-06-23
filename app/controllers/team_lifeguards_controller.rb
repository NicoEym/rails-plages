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

  def edit
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.find(params[:team_id])
    @leader = Rank.find_by(name: "Chef de poste")
    @team_mate = Rank.find_by(name: "Equipier")
    @team_mate_number = @beach.number_of_team_members - 1
    team_lifeguards = TeamLifeguard.new
  end
end
