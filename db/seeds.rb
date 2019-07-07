# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10000.times do
  Survivor.create!(name: Faker::Name.name, age: rand(18..60), gender: [0,1].sample, latitude: [-22,-23].sample + [+rand,-rand].sample, longitude: [-47,-46].sample + [+rand,-rand].sample,
                   inventory: Inventory.new({food: rand(0..20), water: rand(0..20), ammunition: rand(0..20), medication: rand(0..20)}), times_reported: [0,3,3].sample)
end
