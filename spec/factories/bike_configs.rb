FactoryBot.define do
  factory :bike_config do
    association :bike, :factory => :bike
    
    oil_change { Faker::Number.between(from: 500, to: 2500) }
  end
end
