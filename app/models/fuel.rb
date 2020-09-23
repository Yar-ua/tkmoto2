class Fuel < ApplicationRecord
  belongs_to :bikes
  
  validates		:odo, :odo_delta, :refueling, :price_fuel, presence: true
  validates		:odo, :odo_delta, :refueling, :price_fuel, numericality: true

end
