class CreateHeadLifeguards < ActiveRecord::Migration[5.2]
  def change
    create_table :head_lifeguards do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
