

require 'date'
require 'faker'

TeamLifeguard.delete_all
HeadLifeguard.delete_all
Team.delete_all
Calendar.delete_all
Beach.delete_all
User.delete_all

Beach.create(name: "Marché", number_of_team_members: 5, address: "Menton", latitude: 43.774129, longitude: 7.503388, photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSqYqAyO9YHYCYuAsD_SoApKTL0W8r0A1Mc1g&usqp=CAU")
Beach.create(name: "Berlioz", number_of_team_members: 4, address: "Roquebrune Cap-Martin", latitude: 43.761902, longitude: 7.484872, photo_url:"data:image/jpeg;base64,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")
Beach.create(name: "Sablettes", number_of_team_members: 4, address: "Menton", latitude: 43.778335, longitude: 7.508211, photo_url: "https://www.menton.fr/local/cache-gd2/0f/b882bab7f385e4d216d095c9ab2763-resp960.jpg?1589570954")
Beach.create(name: "Golfe Bleu", number_of_team_members: 3, address: "Roquebrune Cap-Martin", latitude: 43.75905, longitude: 7.453404, photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRmgpg8SOhoz-9PcVQisAuLqx9dqWlaBrnNbdo-wGAmRF6hzlw3_aadVE_kcWG6taDEY6f8NgfIrgDySM-nxLeKg31abl4B&usqp=CAU")



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
