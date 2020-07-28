class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :team_lifeguards, dependent: :destroy
  has_many :users, through: :team_lifeguards
  accepts_nested_attributes_for :team_lifeguards, allow_destroy: true

  def lifeguards
    users.where(head: false)
  end

  def head
    users.where(head: true)
  end

  def self.with(this_user)
    teams = self.all
    teams_with_this_user = []
    teams.each do |team|
      team.users.each do |user|
        teams_with_this_user << team if user == this_user
      end
    end
    teams_with_this_user
  end
end
