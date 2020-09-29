class Repair < ApplicationRecord
  belongs_to :bike
  
  validates	:description, presence: true, length: { maximum: 255 }
  validates	:price, presence: true, length: { maximum: 50 }, numericality: true
  validates :date, presence: true
  
end
