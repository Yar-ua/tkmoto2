class FuelsController < ApplicationController
  before_action :set_bike
  before_action :set_fuel, only: [ :edit, :update, :destroy ]

  def index
    @fuels = @bike.fuels.order(id: :desc)
  end
 
  def new
    @fuel = Fuel.new
  end

  def create
    @fuel = @bike.fuels.build(fuel_params)
    respond_to do |format|
      if @fuel.save
        format.html { 
          flash[:success] = 'Fuel was successfully created'
          redirect_to bike_fuels_path(@bike)
        }
        format.json { render :show, status: :created, location: @fuel}
      else
        format.html { render :new }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @fuel.update(fuel_params)
        format.html { 
          flash[:success] = 'Fuel was successfully updated'
          redirect_to bike_fuels_path(bike_id: @fuel.bike_id)
        }
        format.json { render :show, status: :created, location: @fuel}
      else
        format.html { render :edit }
        format.json { render json: @fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @fuel.destroy
        format.html { 
          flash[:success] = 'Fuel was successfully deleted'
          redirect_to bike_fuels_path(bike_id: @fuel.bike_id)
          }
        format.json { head :no_content }
      end
    end
  end


  private
  
  def set_bike
    @bike = Bike.find_by_id(params[:bike_id])
  end

  def set_fuel
    @fuel = Fuel.find_by_id(params[:id])
  end

  def fuel_params
    params.require(:fuel).permit(:bike_id, :odo, :odo_delta, :refueling, :price_fuel, :fuel_station, :fuel_type, :date)
  end

end