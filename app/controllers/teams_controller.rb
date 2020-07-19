class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update, :destroy]

  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.new
    authorize @team
    teams_on_that_day = Team.where(calendar: @date)

    @available_arms = look_for_available_armlifeguard(@team, teams_on_that_day)
    @available_heads = look_for_available_headlifeguard(@team, teams_on_that_day)
    (@beach.number_of_team_members - 1).times { @team.team_lifeguards.build }
    @team.head_lifeguard.build
  end

  def create
    @team = Team.new(team_params)
    authorize @team
    @team.calendar = Calendar.find(params[:calendar_id])
    @team.beach = Beach.find(params[:beach_id])
    if @team.save
      redirect_to calendar_path(@team.calendar)
    else
      @team.team_lifeguards.new unless @team.team_lifeguards.any?
      render :new
    end
  end

  def edit
    @team_lifeguards = TeamLifeguard.where(team: @team)
    @beach = @team.beach
    @date = @team.calendar
    teams_on_that_day = Team.where(calendar: @date)

    @available_arms = look_for_available_armlifeguard(@team, teams_on_that_day)
    @available_heads = look_for_available_headlifeguard(@team, teams_on_that_day)
    team_lifeguards = TeamLifeguard.where(team: @team)
    @this_team_armlifeguards = []
    team_lifeguards.each do |team_lifeguard|
      lifeguard = User.find_by(id: team_lifeguard.user_id)
      if lifeguard.head?
        @head = lifeguard
        @available_heads << @head
      else
        @this_team_armlifeguards << lifeguard
        @available_arms << lifeguard
      end
    end
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def update
    @beach = @team.beach
    if @team.update(team_params)
      redirect_to calendar_path(@team.calendar)
    else
      render :edit
    end
  end

  def destroy
    date = @team.calendar
    @team.destroy
    redirect_to calendar_path(date.id)
  end

  def index
    @teams = policy_scope(Team)
  end

  private

  def set_team
    @team = Team.find(params[:id])
    authorize @team
  end

  def look_for_available_headlifeguard(team, all_teams_on_that_day)
    @available_heads = User.head_lifeguard
    all_teams_on_that_day.each do |team|
      head_lifeguards = HeadLifeguard.where(team: team)
      # we will take out of the list of available chief every lifeguards taht already affected to a team that day
      head_lifeguards.each do |head_lifeguard|
        # we get the user
        @available_heads = @available_heads - [head_lifeguard.user]
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
    params.require(:team).permit(:calendar_id, :beach_id, head_lifeguard_attributes: [:id, :user_id, :_destroy],
                                                          team_lifeguards_attributes: [:id, :user_id, :_destroy])
  end
end
