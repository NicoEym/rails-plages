class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :head_lifeguard, dependent: :destroy
  has_many :team_lifeguards, dependent: :destroy
  has_many :users, through: :team_lifeguards
  has_many :user, through: :head_lifeguard
  accepts_nested_attributes_for :team_lifeguards, allow_destroy: true
  accepts_nested_attributes_for :head_lifeguard, allow_destroy: true

  def lifeguards
    team_lifeguards
  end

  def head
    head_lifeguard
  end

  def self.with(user)
    where(user: user)
  end
end
