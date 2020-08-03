class AddSeasonToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :season, foreign_key: true
  end
end
