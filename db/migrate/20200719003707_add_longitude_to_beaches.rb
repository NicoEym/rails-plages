class AddLongitudeToBeaches < ActiveRecord::Migration[5.2]
  def change
    add_column :beaches, :longitude, :float
    add_column :beaches, :latitude, :float
  end
end
