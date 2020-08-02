class Calendar < ApplicationRecord
  validates :day, presence: true
  has_many :teams
  has_many :availabilities
end
