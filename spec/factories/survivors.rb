require 'faker'
FactoryBot.define do
  factory :survivor do
    name { Faker::Name.name }
    age { Faker::Number.between(18, 60) }
    gender { [0, 1].sample }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :infected do
      times_reported { Faker::Number.between(3, 10) }
    end

    trait :not_infected do
      times_reported { Faker::Number.between(0, 2) }
    end

    trait :with_resources do
      inventory { Inventory.new(water: 100, food: 100, medication: 100, ammunition: 100) }
    end

    trait :without_resources do
      inventory { Inventory.new(water: 0, food: 0, medication: 0, ammunition: 0) }
    end

    factory :infected_survivor do
      times_reported { Faker::Number.between(3, 10) }
      inventory { FactoryBot.build(:inventory) }
    end

    factory :not_infected_survivor do
      times_reported { Faker::Number.between(0, 2) }
      inventory { FactoryBot.build(:inventory) }
    end

    factory :general_survivor do
      times_reported { Faker::Number.between(0, 10) }
      inventory { FactoryBot.build(:inventory) }
    end

    factory :infected_survivor_with_resources, traits: [:infected, :with_resources]
    factory :infected_survivor_without_resources, traits: [:infected, :without_resources]
    factory :not_infected_survivor_with_resources, traits: [:not_infected, :with_resources]
    factory :not_infected_survivor_without_resources, traits: [:not_infected, :without_resources]
  end
end