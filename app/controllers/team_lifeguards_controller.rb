class TeamLifeguardsController < ApplicationController
  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.find(params[:team_id])
    @team_lifeguard = TeamLifeguard.new

    teams_on_that_day = Team.where(calendar: @date)
    @chief_rank = Rank.find_by(name: "Chef de poste")
    @team_mate_rank = Rank.find_by(name: "Equipier")
    @avaible_chiefs = User.where(rank_id: @chief_rank.id)
    @avaible_team_mates = User.where(rank_id: @team_mate_rank.id)
    teams_on_that_day.each do |team|
      team_lifeguards = TeamLifeguard.where(team: team)
      team_lifeguards.each do |team_lifeguard|
        lifeguard = team_lifeguard.user
        if lifeguard.rank_id == @chief_rank.id
          @avaible_chiefs - [lifeguard]
        elsif lifeguard.rank_id == @team_mate_rank.id
          @avaible_team_mates - [lifeguard]
        end
      end
    end

    @team_mate_number = @beach.number_of_team_members - 1
  end

  def create
    @team_lifeguard = TeamLifeguard.new(team_lifeguard_params)
    @team_lifeguard.team = Team.find(params[:team_id])

    @team_lifeguard.save
    if @team_lifeguard.save
      # redirect_to calendar_path(@date.id)
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:team_id])
    @team_lifeguards = TeamLifeguard.where(team: @team)
    @beach = @team.beach
    @date = @team.calendar
    @leader_rank = Rank.find_by(name: "Chef de poste")
    @team_mate_rank = Rank.find_by(name: "Equipier")
    @leader = @team_lifeguards.first
    @team_mates = @team_lifeguards.drop(1)
  end

  def update
    @team_lifeguard = TeamLifeguard.find(params[:id])
    @team_lifeguard.update(team_lifeguard_params)
  end

  private

  def team_lifeguard_params
    params.require(:team_lifeguard).permit(:team_id, :user_id)
  end
end
