class Season < ApplicationRecord
  has_many :calendars, dependent: :destroy
  has_many :lifeguards, dependent: :destroy
  has_many :teams, through: :calendars
end
