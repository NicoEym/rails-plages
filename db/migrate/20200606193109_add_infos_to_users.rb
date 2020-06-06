class AddInfosToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mobile, :string
    add_reference :users, :rank, foreign_key: true
    add_column :users, :avatar_url, :string
  end
end
