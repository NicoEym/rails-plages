class TeamLifeguard < ApplicationRecord
  has_many :users
  belongs_to :team
end
