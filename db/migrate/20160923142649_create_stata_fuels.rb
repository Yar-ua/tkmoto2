class CreateStataFuels < ActiveRecord::Migration[5.0]
  def change
    create_table :stata_fuels do |t|
      
      t.numeric	        :odo 			          # текущие показания одометра, км
      t.numeric	        :odo_delta		      # изменения показателей одометра (пробег), км
      t.numeric	        :refueling		      # кол-во заправленного топлива, л
      t.numeric	        :price_fuel		      # стоимость заправленого топлива, грн
      t.string  	      :fuel_station	      # заправка
      t.string	        :fuel_type		      # марка бензина
      t.references      :bike #, foreign_key: true

      t.timestamps
    end
  end
end
