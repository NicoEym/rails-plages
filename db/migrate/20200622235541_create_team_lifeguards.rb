class CreateTeamLifeguards < ActiveRecord::Migration[5.2]
  def change
    create_table :team_lifeguards do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
