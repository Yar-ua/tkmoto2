# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
require 'faker'

# 1.times do
  bike = FactoryBot.create(:bike)
  # 5.times do
  #   FactoryBot.create(:fuel, bike: bike)
  # end
# end