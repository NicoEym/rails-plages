class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :users

end

