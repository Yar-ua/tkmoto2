class FuelsController < ApplicationController
   before_action :set_view_fuel
   before_action :set_fuel_find, only: [ :edit, :update, :destroy ]

  def index
  end
 
  def new
      @bike = Bike.find(params[:bike_id])
      @stata_err = Fuel.new
  end


  def create

  	@bike = Bike.find(params[:bike_id])
    @stata_err = @bike.fuels.create(fuel_params)
    @stata_fuel = Fuel.new(fuel_params)
    if @stata_err.valid?
      redirect_to new_bike_fuel_path
    else
      render 'new'
    end

 	end


  def show
 
  end


  def edit
    
  end


  def update
    
    @stata_fuel.update(fuel_params)
    redirect_to new_bike_fuel_path
  end


  def destroy
    
    @stata_fuel.destroy
    redirect_to new_bike_fuel_path
  end


  private

    def set_fuel_find
      @stata_fuel = Fuel.find(params[:id])
    end


    def set_view_fuel
      @view_stata_fuel = Fuel.where("bike_id = ?", params[:bike_id]).order(id: :desc)
    end


    def fuel_params
      params.require(:stata_fuel).permit(
                      :bike_id, :odo, :odo_delta, :refueling, 
                      :price_fuel, :fuel_station, :fuel_type
                    )
    end

end