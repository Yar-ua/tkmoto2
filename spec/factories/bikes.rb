FactoryBot.define do
  factory :bike do
    name { Faker::Name.name }
    volume { rand(50...2000) }
    year { rand(1970...2020) }
    color { Faker::Color.color_name }
  end
end