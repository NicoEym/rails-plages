class AddBnssaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bnssa, :boolean
    add_column :users, :pse1, :boolean
    add_column :users, :pse2, :boolean
  end
end
