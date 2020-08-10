class CreateLifeguards < ActiveRecord::Migration[5.2]
  def change
    create_table :lifeguards do |t|
      t.boolean :head
      t.boolean :bnssa
      t.boolean :pse1
      t.boolean :pse2
      t.references :user, foreign_key: true
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
