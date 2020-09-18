class AddValidatedToLifeguards < ActiveRecord::Migration[5.2]
  def change
    add_column :lifeguards, :validated_by_admin, :boolean, :default => false, :null => false
  end
end
