FactoryBot.define do
  factory :fuel do
    association :bike, :factory => :bike

    odo_delta { Faker::Number.number(digits: 3) }
    odo { Faker::Number.number(digits: 3) }
    refueling { Faker::Number.between(from: 5, to: 50) }
    price_fuel { Faker::Number.between(from: 100, to: 1500) }
    date { Faker::Date.between(from: '2010-09-23', to: '2020-09-25') }
  end
end