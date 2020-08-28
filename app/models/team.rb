class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :team_lifeguards, dependent: :destroy
  has_many :lifeguards, through: :team_lifeguards
  accepts_nested_attributes_for :team_lifeguards, allow_destroy: true

  def arm_lifeguards
    lifeguards.where(head: false)
  end

  def head_lifeguard
    lifeguards.where(head: true)
  end

  def self.with(this_lifeguard)
    teams = self.all
    teams_with_this_lifeguard = []
    teams.each do |team|
      team.lifeguards.each do |lifeguard|
        teams_with_this_lifeguard << team if lifeguard == this_lifeguard
      end
    end
    teams_with_this_lifeguard
  end
end
