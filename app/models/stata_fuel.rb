class StataFuel < ApplicationRecord
  belongs_to :bike
  
  validates		:odo, :fuel_station, :fuel_type, length: { maximum: 30, message: "очень длинное название" }

  validates 	:odo_delta, presence: { message: "Введите пробег между заправками" }
  validates		:refueling, presence: { message: "Введите кол-во заправленного топлива" }
  validates     :price_fuel, presence: { message: "Введите сумму оплаты за топливо" }

  validates		:odo_delta, numericality: { message: "Дальность пробега - Введите число, а не текст" }, allow_nil: true
  validates		:refueling, numericality: { message: "кол-во заправленного топлива - введите число, а не текст" }
  validates		:price_fuel, numericality: { message: "Сумма оплаты - введите число, а не текст" }

  validates		:odo_delta, :refueling, :price_fuel, length: { maximum: 12, message: "Не более 12 символов"}
end
