FactoryBot.define do
  factory :oil do
    association :bike, :factory => :bike
    
    oil_change { Faker::Number.between(from: 1000, to: 50000) }
  end
end
