class Calendar < ApplicationRecord
  validates :day, presence: true
  has_many :teams
end
