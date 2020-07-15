class TeamsController < ApplicationController

  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.new
    teams_on_that_day = Team.where(calendar: @date)

    @availalable_arms = look_for_available_armlifeguard(@team, teams_on_that_day)
    @availalable_heads = look_for_available_headlifeguard(@team, teams_on_that_day)
    @team_mate_number = @beach.number_of_team_members - 1
    @new_head = @team.team_lifeguards.new
    @new_lifeguards = []
    (@beach.number_of_team_members - 1).times do
      @new_lifeguards << @team.team_lifeguards.new
    end
  end

  def create
    @team = Team.new(team_params)
    @team.calendar = Calendar.find(params[:calendar_id])
    @team.beach = Beach.find(params[:beach_id])
    if @team.save
      redirect_to calendar_path(@team.calendar)
    else
      @team.team_lifeguards.new unless @team.team_lifeguards.any?
      render :new
    end
  end

  def destroy
    @team = Team.find(params[:id])
    date = @team.calendar
    @team.destroy
    redirect_to calendar_path(date.id)
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

  def team_params
    params.require(:team).permit(:calendar_id, :beach_id, team_lifeguards_attributes: :user_id)
  end
end
