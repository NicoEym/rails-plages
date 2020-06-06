class CreateBeaches < ActiveRecord::Migration[5.2]
  def change
    create_table :beaches do |t|
      t.string :name
      t.string :address
      t.integer :number_of_team_members

      t.timestamps
    end
  end
end
