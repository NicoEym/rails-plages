class AddDefaultToLifeguards < ActiveRecord::Migration[5.2]
  def change
    change_column :lifeguards, :head, :boolean, :default => false, :null => false
    change_column :lifeguards, :bnssa, :boolean, :default => false, :null => false
    change_column :lifeguards, :pse1, :boolean, :default => false, :null => false
    change_column :lifeguards, :pse2, :boolean, :default => false, :null => false
    change_column :availabilities, :available, :boolean, :default => true, :null => false
  end
end
