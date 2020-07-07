class TeamLifeguardsController < ApplicationController
  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.find(params[:team_id])
    @team_lifeguard = TeamLifeguard.new

    teams_on_that_day = Team.where(calendar: @date)

    @availalable_arms = look_for_available_armlifeguard(@team, teams_on_that_day)
    @availalable_heads = look_for_available_headlifeguard(@team, teams_on_that_day)
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

    @available_arms = look_for_available_armlifeguard(@team, teams_on_that_day)
    @available_heads = look_for_available_headlifeguard(@team, teams_on_that_day)
    lifeguards = TeamLifeguard.where(team: @team)
    lifeguards.each do |lifeguard|
      user = User.find_by(id: lifeguard.user_id)
      user.head? ? @available_heads << user : @available_arms << user
    end
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def update
    @team_lifeguard = TeamLifeguard.find(params[:id])
    @team_lifeguard.update(team_lifeguard_params)
  end

  private

  def look_for_available_headlifeguard(team, all_teams_on_that_day)
    @available_heads = User.head_lifeguard
    all_teams_on_that_day.each do |team|
      team_lifeguards = TeamLifeguard.where(team: team)
      # we will take out of the list of available chief every lifeguards taht already affected to a team that day
      team_lifeguards.each do |team_lifeguard|
        # we get the user
        @available_heads = @available_heads - [team_lifeguard.user]
        # if the user is a team_mate, we take it out of the list of available team_mates
      end
    end
    @available_heads
  end

  def look_for_available_armlifeguard(team, all_teams_on_that_day)
    @available_arms = User.arm_lifeguard
    all_teams_on_that_day.each do |team|
      team_lifeguards = TeamLifeguard.where(team: team)
      # we will take out of the lsit of available chief every lifeguards taht already affected to a team that day
      team_lifeguards.each do |team_lifeguard|
        # we get the user
        @available_arms = @available_arms - [team_lifeguard.user]
      end
    end
    @available_arms
  end

  def team_lifeguard_params
    params.require(:team_lifeguard).permit(:team_id, :user_id)
  end
end
