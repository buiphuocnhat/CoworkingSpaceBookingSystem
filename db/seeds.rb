require "faker"
10.times do
  UserRole.create(role: Faker::Team.name)
end
10.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, phone: "0532200305",password:"abc123",password_confirmation: "abc123")
end
10.times do
  Venue.create(name:Faker::Company.name, user_id: rand(1..10))
end
10.times do
  Address.create(name: Faker::Address.street_address, city: Faker::Address.city, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,venue_id: rand(1..10))
end
3.times do
  Type.create(name: Faker::Name.name)
end
10.times do
  SpacePrice.create(per_month: rand(1..100),per_day: rand(1..100), per_hour: rand(1..100))
end
30.times do
  Space.create(name: Faker::Name.name, capacity: rand(1..100), description: Faker::Quotes::Shakespeare.romeo_and_juliet_quote, hour_open: Time.parse('08:00:00'), hour_close: Time.parse('17:00:00'), status:true,picture: Faker::Avatar.image, venue_id: rand(1..10), user_id: rand(1..3), type_id: rand(1..3), space_price_id: rand(1..10))
end
10.times do
  BookingDetail.create(time_use_start: Faker::Date.in_date_period(year: 2019, month: 2), time_use_close: Faker::Date.in_date_period(year: 2020, month: 12), status: true,space_id: rand(1..10), user_id: rand(1..10))
end
10.times do
  Payment.create(method: Faker::ProgrammingLanguage.name,booking_detail_id: rand(1..10), status: true)
end
