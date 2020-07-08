class AddHeadToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :head, :boolean
  end
end
