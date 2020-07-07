class RemoveRankFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :rank_id, :integer
  end
end
