class AddAvailableToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :available, :boolean
  end
end
