class Availability < ApplicationRecord
  belongs_to :lifeguard
  belongs_to :calendar
end
