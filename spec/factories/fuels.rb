FactoryBot.define do
  factory :fuel do
    association :bike, :factory => :bike

    odo_delta { Faker::Number.number(digits: 3) }
    odo { odo + odo_delta }
    refueling { Faker::Number.between(from: 5, to: 50) }
    price_fuel { Faker::Number.between(from: 100, to: 1500) }
  end
end