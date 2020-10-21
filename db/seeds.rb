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