class CreateStataFuels < ActiveRecord::Migration[5.0]
  def change
    create_table :stata_fuels do |t|
      
      t.numeric	        :odo 			          
      t.numeric	        :odo_delta		      
      t.numeric	        :refueling		      
      t.numeric	        :price_fuel		      
      t.string  	      :fuel_station	      
      t.string	        :fuel_type		      
      t.references      :bike 

      t.timestamps
    end
  end
end
