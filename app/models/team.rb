class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :team_lifeguards, dependent: :destroy
  has_many :users, through: :team_lifeguards
  accepts_nested_attributes_for :team_lifeguards, allow_destroy: true
end
