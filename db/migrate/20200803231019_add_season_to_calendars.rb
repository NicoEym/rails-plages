class AddSeasonToCalendars < ActiveRecord::Migration[5.2]
  def change
    add_reference :calendars, :season, foreign_key: true
  end
end
