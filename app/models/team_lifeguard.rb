class TeamLifeguard < ApplicationRecord
  belongs_to :lifeguard
  belongs_to :team
end
