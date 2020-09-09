class Season < ApplicationRecord
  has_many :calendars
  has_many :lifeguards
  has_many :teams, through: :calendars
end
