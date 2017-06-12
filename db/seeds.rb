# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#if Listing.count == 0
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
#end