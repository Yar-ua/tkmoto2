# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'

2.times do
  user = FactoryBot.create(:user)
  3.times do
    FactoryBot.create(:bike, user: user)
  end
end

### this seed option used for creating special user for manual application testing
user = FactoryBot.create(:myuser)
2.times do
  bike = FactoryBot.create(:bike, user: user)
  18.times do
    FactoryBot.create(:fuel, bike: bike)
  end
  8.times do
    FactoryBot.create(:oil, bike: bike)
  end
  15.times do
    FactoryBot.create(:repair, bike: bike)
  end  
  FactoryBot.create(:bike_config, bike: bike)
end