class RemoveAvailabilitiesFromUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :team_lifeguards, :lifeguard_id, :user_id
    rename_column :availabilities, :lifeguard_id, :user_id

    remove_reference :team_lifeguards, :user, index: true, foreign_key: true
    remove_reference :availabilities, :user, index: true, foreign_key: true
    add_reference :team_lifeguards, :lifeguard, index: true, foreign_key: true
    add_reference :availabilities, :lifeguard, index: true, foreign_key: true
  end
end
