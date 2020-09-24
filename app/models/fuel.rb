class Fuel < ApplicationRecord
  belongs_to :bike
  
  validates		:odo, presence: true, length: { maximum: 50 }, numericality: true
  validates   :odo_delta, presence: true, length: { maximum: 50 }, numericality: true
  validates   :refueling, presence: true, length: { maximum: 50 }, numericality: true
  validates   :price_fuel, presence: true, length: { maximum: 50 }, numericality: true

end
