class TeamLifeguardsController < ApplicationController
  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.find(params[:team_id])
    @team_lifeguard = TeamLifeguard.new

    teams_on_that_day = Team.where(calendar: @date)

    @avaible_team_mates = look_for_available_teammates(@team, teams_on_that_day)
    @avaible_chiefs = look_for_available_chiefs(@team, teams_on_that_day)
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
    @team_lifeguard = TeamLifeguard.find_by(team: @team)
    @beach = @team.beach
    @date = @team.calendar

    teams_on_that_day = Team.where(calendar: @date)

    @avaible_team_mates = look_for_available_teammates(@team, teams_on_that_day)
    @avaible_chiefs = look_for_available_chiefs(@team, teams_on_that_day)
    lifeguards = TeamLifeguard.where(team: @team)
    lifeguards.each do |lifeguard|
      user = User.find_by(id: lifeguard.user_id)
      user.rank.name == "Chef de poste" ? @avaible_chiefs << user : @avaible_team_mates << user
    end
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def update
    @team_lifeguard = TeamLifeguard.find(params[:id])
    @team_lifeguard.update(team_lifeguard_params)
  end

  private

  def look_for_available_chiefs(team, all_teams_on_that_day)
    @chief_rank = Rank.find_by(name: "Chef de poste")
    @avaible_chiefs = User.where(rank_id: @chief_rank.id)
    all_teams_on_that_day.each do |team|
      team_lifeguards = TeamLifeguard.where(team: team)
      # we will take out of the list of available chief every lifeguards taht already affected to a team that day
      team_lifeguards.each do |team_lifeguard|
        # we get the user
        @avaible_chiefs = @avaible_chiefs - [team_lifeguard.user]
        # if the user is a team_mate, we take it out of the list of available team_mates
      end
    end
    @avaible_chiefs
  end

  def look_for_available_teammates(team, all_teams_on_that_day)
    @team_mate_rank = Rank.find_by(name: "Equipier")
    @avaible_team_mates = User.where(rank_id: @team_mate_rank.id)
    all_teams_on_that_day.each do |team|
      team_lifeguards = TeamLifeguard.where(team: team)
      # we will take out of the lsit of available chief every lifeguards taht already affected to a team that day
      team_lifeguards.each do |team_lifeguard|
        # we get the user
          @avaible_team_mates = @avaible_team_mates - [team_lifeguard.user]

      end
    end
    @avaible_team_mates
  end


  def team_lifeguard_params
    params.require(:team_lifeguard).permit(:team_id, :user_id)
  end
end
