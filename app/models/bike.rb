class Bike < ApplicationRecord
  has_many :stata_fuels, dependent: :destroy, validate: true
  has_many :stata_repairs, dependent: :destroy, validate: true
  validates_associated :stata_fuels
  validates_associated :stata_repairs

  validates	:name,  presence: true, 
                    length: { maximum: 50 }
  validates :year,  presence: true, 
                    length: { maximum: 4 },
                    numericality: { only_integer: true }
  validates	:color, presence: true, 
                    length: { maximum: 50 }
	
end