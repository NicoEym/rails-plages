class TeamsController < ApplicationController
  require "date"
  before_action :set_team, only: [:edit, :update, :destroy]

  def new
    # we define all the params that will be used in the form
    @date = Calendar.find(params[:calendar_id])
    @season = @date.season
    @beach = Beach.find(params[:beach_id])
    @team = Team.new

    # we check the authorization
    authorize @team

    # we get the available lifeguards for this date: @available_arms and @available_heads
    get_available_lifeguards(@date)

    # we build the team_lifeguards for the form
    (@beach.number_of_team_members).times { @team.team_lifeguards.build }

    # the variable below will be used to  build the form
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def create
    # we create our new team using the params and go through the authorization
    @team = Team.new(team_params)
    authorize @team

    # we affect the calendar and the beach since they are not coming in the team_params
    @team.calendar = Calendar.find(params[:calendar_id])
    @team.beach = Beach.find(params[:beach_id])

    # we save our team
    if @team.save
      redirect_to season_calendar_path(@team.calendar.season, @team.calendar)
    else
      @team.team_lifeguards.new unless @team.team_lifeguards.any?
      render :new
    end
  end

  def edit
    # we load the team_lifeguards that belong to this team
    @team_lifeguards = TeamLifeguard.where(team: @team)

    # we get the available lifeguards for this date: @available_arms and @available_heads
    get_available_lifeguards(@date)

    # we put current team lifeguards in the array because, since they are already affected to a team (this team)...
    # ... they have not been found by the method look_for_available_armlifeguard
    @team.lifeguards.each do |team_mate|
      @available_arms << team_mate
    end

    # same logic for the head lifeguard
    @available_heads << @team.head_lifeguard.first

    # the variable below will be used to  build the form
    @team_mate_number = @beach.number_of_team_members - 1
  end

  def update
    puts team_params
    if @team.update(team_params)
      redirect_to season_calendar_path(@team.calendar.season, @team.calendar)
    else
      render :edit
    end
  end

  def destroy
    # after passing by the we destroy the team and redirect
    @team.destroy
    redirect_to season_calendar_path(@season, @date)
  end

  def index
    @user_affected_teams = policy_scope(Team)
    # short method to identify the references date of the index for the user
    reference_date = find_reference_date

    @user_program_for_the_next_7_days = []
    for i in 0..6
      date = reference_date + i
      date_for_test = Calendar.find_by(day: date)
      unless date_for_test.nil?
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
    end
    @user_program_for_the_next_7_days
  end

  private

  def find_reference_date
    reference_date = Date.today
    reference_date = current_user.lifeguard.season.start_date if reference_date < current_user.lifeguard.season.start_date
  end

  def is_working_on_that_day?(date, teams)
    # we check whether the user is affected to a team that will work of that date
    team = teams.find_by(calendar_id: date.id)
    team.nil? ? false : true
  end

  def set_team
    @team = Team.find(params[:id])
    authorize @team
     # we affect some variable that are used in the form
    @beach = @team.beach
    @date = @team.calendar
    @season = @team.season
  end

  def get_available_lifeguards(date)
    # we get all the teams already created on this day
    teams_on_that_day = date.teams
    # We will load all the unaffected team mates
    @available_arms = look_for_available_armlifeguard(teams_on_that_day, date)
    # We will load all the unaffected head lifeguards
    @available_heads = look_for_available_headlifeguard(teams_on_that_day, date)
  end

  def look_for_available_headlifeguard(every_team_on_that_day, date)
    # we get all the head lifeguards that can work
    @available_heads = Lifeguard.head_lifeguards_all
    @available_heads = @available_heads.available_on_that_date(date)
    # for each team on that day
    every_team_on_that_day.each do |team|
      # we get the user
      @available_heads = @available_heads - team.head_lifeguard
      # if the user is a team_mate, we take it out of the list of available team_mates
    end
    @available_heads
  end

  def look_for_available_armlifeguard(every_team_on_that_day, date)
    # we get all the team lifeguards that can work
    @available_arms = Lifeguard.arm_lifeguards_all
    @available_arms = @available_arms.available_on_that_date(date)
    # for each team on that day
    every_team_on_that_day.each do |team|
      # we get the user
      @available_arms = @available_arms - team.arm_lifeguards
    end
    @available_arms
  end

  def team_params
    params.require(:team).permit(:calendar_id, :beach_id, team_lifeguards_attributes: [:id, :lifeguard_id, :_destroy])
  end
end
