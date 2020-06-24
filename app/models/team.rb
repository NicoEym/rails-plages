class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :team_lifeguards, dependent: :destroy
  has_many :users, through: :team_lifeguards
end
