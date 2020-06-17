class TeamsController < ApplicationController


  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.new
    @leader = Rank.find_by(name: "Chef de poste")
    @team_mate = Rank.find_by(name: "Equipier")
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def create
    @team = Team.new(team_params)
    @team.calendar = Calendar.find(params[:calendar_id])
    if @team.save
      redirect_to calendar_path(@team.calendar)
    else
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:calendar_id, :beach_id)
  end


end
