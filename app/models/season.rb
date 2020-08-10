class Season < ApplicationRecord
  has_many :calendars
  has_many :lifeguards
end
