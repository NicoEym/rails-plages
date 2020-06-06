class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.references :beach, foreign_key: true
      t.references :calendar, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
