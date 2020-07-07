class DropRanksTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :ranks
  end
end
