class Beach < ApplicationRecord
  validates :name, presence: true
  validates :number_of_team_members, presence: true
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_city_name?
  has_many :teams
end
