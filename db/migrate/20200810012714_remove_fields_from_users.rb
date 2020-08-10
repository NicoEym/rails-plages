class RemoveFieldsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :bnssa, :boolean
    remove_column :users, :pse1, :boolean
    remove_column :users, :pse2, :boolean
    remove_column :users, :head, :boolean
    remove_column :users, :season_id
  end
end
