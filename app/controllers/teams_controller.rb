class TeamsController < ApplicationController
  require "date"
  before_action :set_team, only: [:edit, :update, :destroy]

  def new
    @date = Calendar.find(params[:calendar_id])
    @season = @date.season
    @beach = Beach.find(params[:beach_id])
    @team = Team.new
    authorize @team
    teams_on_that_day = @date.teams
    # We will load all the unaffected team mates
    @available_arms = look_for_available_armlifeguard(teams_on_that_day)
    # We will load all the unaffected head lifeguards
    @available_heads = look_for_available_headlifeguard(teams_on_that_day)
    (@beach.number_of_team_members).times { @team.team_lifeguards.build }
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def create
    @team = Team.new(team_params)
    authorize @team

    @team.calendar = Calendar.find(params[:calendar_id])
    @team.beach = Beach.find(params[:beach_id])
    if @team.save
      redirect_to season_calendar_path(@team.calendar.season, @team.calendar)
    else
      @team.team_lifeguards.new unless @team.team_lifeguards.any?
      render :new
    end
  end

  def edit
    @team_lifeguards = TeamLifeguard.where(team: @team)
    @beach = @team.beach
    @date = @team.calendar
    teams_on_that_day = @date.teams

    @available_arms = look_for_available_armlifeguard(teams_on_that_day)
    @available_heads = look_for_available_headlifeguard(teams_on_that_day)
    @team.lifeguards.each  do |team_mate|
      @available_arms << team_mate
    end
    @available_heads << @team.head.first
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
    @user_affected_teams = policy_scope(Team)
    today = Date.today
    @user_program_for_the_next_7_days = []
    for i in 0..6
      date = today + i
      date_for_test = Calendar.find_by(day: date)
      # // for this date, if we have less team created than number of beaches, the plaaning has not been finalized yet
      if date_for_test.teams.count < Beach.all.count
        @user_program_for_the_next_7_days <<  { program: "Planning not created for this day", date: date_for_test }
      # // we check if the user is affected to a beach. If it is not the case, we send a program Rest
      elsif is_working_on_that_day?(date_for_test, @user_affected_teams) == false
        @user_program_for_the_next_7_days <<  { program: "Rest", date: date_for_test }
      # // we check if the user is affected to a beach. If it is  the case, we send a program Working with the details of the team
      elsif is_working_on_that_day?(date_for_test, @user_affected_teams)
        @user_program_for_the_next_7_days << { program: "Working", team: @user_affected_teams.find_by(calendar_id: date_for_test.id), date: date_for_test }
      end
    end
    @user_program_for_the_next_7_days
  end

  private

  def is_working_on_that_day?(date, teams)
    team = teams.find_by(calendar_id: date.id)
    team.nil? ? false : true
  end

  def set_team
    @team = Team.find(params[:id])
    authorize @team
  end

  def look_for_available_headlifeguard(every_team_on_that_day)
    # we get all the head lifeguards that can work
    @available_heads = Lifeguard.head_lifeguard
    # for each team on that day
    every_team_on_that_day.each do |team|
      puts "All heads #{@available_heads}"
      puts "this chief #{team.head}"
      # we get the user
      @available_heads = @available_heads - team.head
      # if the user is a team_mate, we take it out of the list of available team_mates
    end
    @available_heads
  end

  def look_for_available_armlifeguard(every_team_on_that_day)
    # we get all the team lifeguards that can work
    @available_arms = Lifeguard.arm_lifeguard
    # for each team on that day
    every_team_on_that_day.each do |team|
       # we get the user
      @available_arms = @available_arms - team.lifeguards
    end
    @available_arms
  end

  def team_params
    params.require(:team).permit(:calendar_id, :beach_id, team_lifeguards_attributes: [:id, :lifeguard_id, :_destroy])
  end
end
