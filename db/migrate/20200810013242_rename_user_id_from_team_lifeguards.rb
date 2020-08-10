class RenameUserIdFromTeamLifeguards < ActiveRecord::Migration[5.2]
  def change
    rename_column :team_lifeguards, :user_id, :lifeguard_id
    rename_column :availabilities, :user_id, :lifeguard_id
  end
end
