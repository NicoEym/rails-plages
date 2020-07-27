class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update, :destroy]

  def new
    @date = Calendar.find(params[:calendar_id])
    @beach = Beach.find(params[:beach_id])
    @team = Team.new
    authorize @team
    teams_on_that_day = Team.where(calendar: @date)

    # We will load all the unaffected team mates
    @available_arms = look_for_available_armlifeguard(teams_on_that_day)
    # We will load all the unaffected head lifeguards
    @available_heads = look_for_available_headlifeguard(teams_on_that_day)
    (@beach.number_of_team_members - 1).times { @team.team_lifeguards.build }
    @team.head_lifeguard.build
  end

  def create
    @team = Team.new(team_params)
    authorize @team
    puts team_params
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

    @available_arms = look_for_available_armlifeguard(teams_on_that_day)
    @available_heads = look_for_available_headlifeguard(teams_on_that_day)

    this_team_affected_lifeguards = TeamLifeguard.where(team: @team)
    this_team_affected_lifeguards.each do |lifeguard|
      @available_arms << lifeguard.user
    end
    puts @available_arms

    this_team_affected_heads = HeadLifeguard.where(team: @team)
    this_team_affected_heads.each do |head|
      @available_heads << head.user
    end
    puts @available_heads
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def update
    @date = @team.calendar
    @beach = @team.beach = Beach.find(params[:beach_id])
    puts team_params
    if @team.update(team_params)
      redirect_to calendar_path(@team.calendar)
    else
      @team.team_lifeguards.new unless @team.team_lifeguards.any?
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
    @dates = Calendar.all.order('day desc')
  end

  private

  def set_team
    @team = Team.find(params[:id])
    authorize @team
  end

  def look_for_available_headlifeguard(all_teams_on_that_day)
    # we get all the head lifeguard that can work
    @available_heads = User.head_lifeguard
    # for each team on that day
    all_teams_on_that_day.each do |team|
      # we get the chief
      head_lifeguards = HeadLifeguard.where(team: team)
      # we will take out of the list of available chief every lifeguards that already affected to a team that day
      head_lifeguards.each do |head_lifeguard|
        # we get the user
        @available_heads = @available_heads - [head_lifeguard.user]
        # if the user is a team_mate, we take it out of the list of available team_mates
      end
    end
    @available_heads
  end

  def look_for_available_armlifeguard(all_teams_on_that_day)
    # we get all the team lifeguards that can work
    @available_arms = User.arm_lifeguard
    # for each team on that day
    all_teams_on_that_day.each do |team|
      # from the lsit of all the life guard
      team_lifeguards = TeamLifeguard.where(team: team)
      # we will take out of the list every lifeguards that is already affected to a team that day
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
