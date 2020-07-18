class AddPhotoToBeaches < ActiveRecord::Migration[5.2]
  def change
    add_column :beaches, :photo_url, :string
  end
end
