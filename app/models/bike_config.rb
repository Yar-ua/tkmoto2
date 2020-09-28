class BikeConfig < ApplicationRecord
  belongs_to :bike
  
  validates :oil_change, presence: true, length: { maximum: 10 }, numericality: true
  
end
