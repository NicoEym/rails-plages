class Team < ApplicationRecord
  belongs_to :beach
  belongs_to :calendar
  has_many :users, rank_name: 'member'
  has_one :user, rank_name: 'chief'
end
