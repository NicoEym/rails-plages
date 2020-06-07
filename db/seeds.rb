

require 'date'
require 'faker'

Beach.delete_all
Calendar.delete_all
Rank.delete_all


Beach.create(name: "Marché", number_of_team_members: 5)
Beach.create(name: "Berlioz", number_of_team_members: 4)
Beach.create(name: "Sablettes", number_of_team_members: 4)

Rank.create(name: "Cadre Plage")

dates = Date.new(2020, 6, 15)
Calendar.create(day: dates)

dates = Date.new(2020, 6, 16)
Calendar.create(day: dates)

dates = Date.new(2020, 6, 17)
Calendar.create(day: dates)

rank = Rank.create(name: "Chef de poste")

# 4.times do
#   user = User.new(

#     firstname:  Faker::Name.first_name,
#     lastname: Faker::Name.last_name,
#     mobile: Faker::PhoneNumber.cell_phone,
#     email: Faker::Internet.email,
#     rank: rank,
#     avatar_url: Faker::Avatar.image,
#     password:  'valid_password',
#     password_confirmation: 'valid_password'
#   )
#   user.save!
# end


# rank = Rank.create(name: "Equipier")
# 8.times do
#   user = User.new(

#     firstname:    Faker::Name.first_name ,
#     lastname: Faker::Name.last_name,
#     mobile: Faker::PhoneNumber.cell_phone,
#     email: Faker::Internet.email,
#     rank: rank,
#     avatar_url: Faker::Avatar.image,
#     password:  'valid_password',
#     password_confirmation: 'valid_password'
#   )
#   user.save!
# end
