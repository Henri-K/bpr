# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Loading Agents...\n"

if Agent.count == 0
   max = Agent.create(name: "Max Damour", avatar: "http://bluepandarealty.com/wp-content/uploads/2015/08/MAX-300x300.jpg", email: "max@bluepandarealty.com")
   irina = Agent.create(name: "Irina Popova", avatar: "http://bluepandarealty.com/wp-content/uploads/2016/04/IRINA-300x300.jpg", email: "irina@bluepandarealty.com")
   bryan = Agent.create(name: "Bryan Nadeau", avatar: "http://bluepandarealty.com/wp-content/uploads/2016/06/BRYAN-web-300x300.jpg", email: "bryan@bluepandarealty.com")
   greg = Agent.create(name: "Greg Campbell", avatar: "http://bluepandarealty.com/wp-content/uploads/2017/04/greg-copy-250x250.jpg", email: "greg@bluepandarealty.com")
end

puts "Agents loaded.\n"

puts "Loading Clients...\n"

if Client.count == 0
   [max, irina, bryan, greg].each do |agent|
      2.times {Client.create(name: Faker::Name.first_name + " " + Faker::Name.last_name,
                             email: Faker::Name.first_name + "@fakemail.com",
                             down_payment: Faker::Number.between(5, 100) * 1000,
                             down_payment_type: "dollars",
                             amort: [25,30][Faker::Number.between(0, 1)],
                             agent: agent)}
      2.times {Client.create(name: Faker::Name.first_name + " " + Faker::Name.last_name,
                             email: Faker::Name.first_name + "@fakemail.com",
                             down_payment: Faker::Number.between(5, 50),
                             down_payment_type: "percent",
                             amort: [25,30][Faker::Number.between(0, 1)],
                             agent: agent)}
   end
end

puts "Clients loaded.\n"

puts "Loading Listings...\n"
if Listing.count == 0
   (0..10).each do |i|
      Listing.create(address: Faker::Address.street_address + "," + Faker::Address.city + "," + Faker::Address.state + "," + Faker::Address.zip,
                     beds: Faker::Number.between(1, 4),
                     baths: Faker::Number.between(1, 3),
                     parking: Faker::Number.between(0, 1),
                     square_footage: Faker::Number.between(300, 2000),
                     year_built: Faker::Number.between(1950, 2017),
                     listing_date: Faker::Date.backward(60),
                     asking_price: Faker::Number.between(20, 100) * 10000,
                     parking_price: Faker::Number.between(20, 35) * 1000,
                     condo_fees: Faker::Number.between(100, 1000),
                     property_tax: Faker::Number.between(100, 350),
                     utility_cost: Faker::Number.between(100, 500),
                     rent_amount: Faker::Number.between(10, 25) * 100) 
   end
end

puts "Listings loaded.\n"