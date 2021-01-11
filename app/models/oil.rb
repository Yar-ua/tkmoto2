class Oil < ApplicationRecord
  belongs_to :bike
  
  validates :oil_change, numericality: { greater_than_or_equal_to: 0 }
  validates :oil_change, presence: true, length: { maximum: 50 }
end
