class BikeConfig < ApplicationRecord
  belongs_to :bike
  
  validates :oil_change, length: { maximum: 10 }, numericality: { only_integer: true }
  
end
