class Calendar < ApplicationRecord
  validates :day, presence: true
  belongs_to :season
  has_many :teams, dependent: :destroy
  has_many :availabilities

  def status
    number_of_team_on_that_day = teams.count

    if number_of_team_on_that_day == Beach.all.count
      status = "completed"
    elsif number_of_team_on_that_day > 0
      status = "initiated"
    else
      status = "uninitiated"
    end
  end
end
