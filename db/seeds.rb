

require 'date'
require 'faker'

TeamLifeguard.delete_all
HeadLifeguard.delete_all
Team.delete_all
Calendar.delete_all
Beach.delete_all
User.delete_all

Beach.create(name: "Marché", number_of_team_members: 5)
Beach.create(name: "Berlioz", number_of_team_members: 4)
Beach.create(name: "Sablettes", number_of_team_members: 4)

dates = Date.new(2020, 6, 15)
Calendar.create(day: dates)

dates = Date.new(2020, 6, 16)
Calendar.create(day: dates)

dates = Date.new(2020, 6, 17)
Calendar.create(day: dates)


for i in 2..10
  user = User.new(

    firstname:  Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    mobile: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    head: true,
    avatar_url: "https://i.pravatar.cc/150?img=#{i}",
    password:  'valid_password',
    password_confirmation: 'valid_password'
  )
  user.save!
end

for i in 11..30
  user = User.new(

    firstname:    Faker::Name.first_name ,
    lastname: Faker::Name.last_name,
    mobile: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    head: false,
    avatar_url: "https://i.pravatar.cc/150?img=#{i}",
    password:  'valid_password',
    password_confirmation: 'valid_password'
  )
  user.save!
end
