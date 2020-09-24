class Bike < ApplicationRecord
  has_many :fuels, dependent: :destroy

  validates	:name,   presence: true, 
                     length: { maximum: 50 }
  validates :year,   presence: true, 
                     length: { maximum: 4 },
                     numericality: { only_integer: true }
  validates	:color,  presence: true, 
                     length: { maximum: 50 }
  validates :volume, presence: true,
                     length: { maximum: 10 },
                     numericality: { only_integer: true }
	
end