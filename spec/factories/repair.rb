FactoryBot.define do
  factory :repair do
    association :bike, :factory => :bike
    
    description { Faker::Lorem.sentence }
    note { Faker::Lorem.paragraph(sentence_count: 5) }
    price { Faker::Number.between(from: 100, to: 1000) }
    date { Faker::Date.between(from: '2010-09-23', to: '2020-09-25') }
  end
end