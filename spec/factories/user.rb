FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.first_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.unique.password }
  end
  
  factory :myuser, class: "User" do
    name { '111' }
    email { '1@mail.com' }
    password { '111111' }
  end
end