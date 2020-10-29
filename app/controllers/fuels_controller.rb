class FuelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bike
  before_action :set_fuel, only: [:show, :update, :destroy ]

  def index
    @fuels = @bike.fuels.order(odo: :desc)
  end
 
  def new
    @fuel = Fuel.new
  end
  
  def show
  end

  def create
    if current_user_is_bike_owner
    
      @fuel = @bike.fuels.build(fuel_params)
      respond_to do |format|
        if @fuel.save
          format.html { 
            flash[:success] = 'Fuel was successfully created'
            redirect_to bike_fuels_path(@bike)
          }
          format.json { render @fuel, status: 200 }
        else
          format.html { 
            flash[:error] = 'Something going wrong, try again'
            render :new 
          }
          format.json { render json: @fuel.errors, status: 422 }
        end
      end
      
    else
      respond_error_not_owner
    end
  end

  def update
    if current_user_is_bike_owner
    
      respond_to do |format|
        if @fuel.update(fuel_params)
        format.html { 
          flash[:success] = 'Fuel was successfully updated'
          redirect_to bike_fuels_path(bike_id: @fuel.bike_id)
          }
          format.json { render @fuel, status: 200}
        else
          format.html { 
            flash[:error] = 'Something going wrong, try again'
            render :edit 
          }
          format.json { render json: @fuel.errors, status: :unprocessable_entity }
        end
      end
      
    else
      respond_error_not_owner
    end
  end

  def destroy
    if current_user_is_bike_owner
      if @fuel.destroy
        render json: { success: true, status: 200 }
      else
        render json: { errors: 'You have not credentials', status: 422 }, status: 422
      end
    else
      respond_error_not_owner
    end
  end


  private
  
  def set_bike
    @bike = Bike.find(params[:bike_id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "Bike not found" }, status: 404
  end

  def set_fuel
    @fuel = Fuel.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "Fuel not found" }, status: 404
  end

  def fuel_params
    params.require(:fuel).permit(:bike_id, :odo, :odo_delta, :refueling, :price_fuel, :fuel_station, :fuel_type, :date)
  end

end