require 'faker'
FactoryBot.define do
  factory :inventory do
    water  {Faker::Number.between(1, 9)}
    food   {Faker::Number.between(1, 9)}
    medication {Faker::Number.between(1, 9)}
    ammunition { Faker::Number.between(1, 9) }
    cached_points { 0 }
  end
end
