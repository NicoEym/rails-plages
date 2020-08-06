class Calendar < ApplicationRecord
  validates :day, presence: true
  belongs_to :season
  has_many :teams
  has_many :availabilities
end

