class Bike < ApplicationRecord
  has_many :stata_fuels, dependent: :destroy, validate: true
  has_many :stata_repairs, dependent: :destroy, validate: true
  validates_associated :stata_fuels
  validates_associated :stata_repairs

  validates	:name,  presence: true, 
                    length: { maximum: 30, message: "enter bike model - 30 symbols max" }
  validates :year,  numericality: { only_integer: true, message: "year must be digit" }, 
                    length: { maximum: 4, message: "enter bike year, must be not longer than 4 digits" }
  validates	:color, presence: true, 
                    length: { maximum: 30, message: "enter bike color, 30 symbols max" }
	
end