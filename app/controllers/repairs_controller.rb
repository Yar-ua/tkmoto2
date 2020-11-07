class RepairsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bike
  before_action :set_repair, only: [ :show, :update, :destroy ]

  def index
    @repairs = @bike.repairs.order(date: :desc)
  end

  def new
    @repair = Repair.new
  end
  
  def create
    if current_user_is_bike_owner
      
      @repair = @bike.repairs.build(repair_params)
      respond_to do |format|
        if @repair.save
          format.html { 
            flash[:success] = 'Repair was successfully created'
            redirect_to bike_repairs_path(@bike)
          }
          format.json { render @repair, status: 200}
        else
          format.html { 
            flash[:error] = 'Something going wrong, try again'
            render :new 
          }
          format.json { render json: @repair.errors, status: 422 }
        end
      end
      
    else
      respond_error_not_owner
    end
  end
  
  def show
  end
  
  def update
    if current_user_is_bike_owner
    
      respond_to do |format|
        if @repair.update(repair_params)
          format.html { 
            flash[:success] = 'Repair was successfully updated'
            redirect_to bike_repairs_path(bike_id: @repair.bike_id)
          }
          format.json { render @repair, status: 200}
        else
          format.html { 
            flash[:error] = 'Something going wrong, try again'
            render :edit 
          }
          format.json { render json: @repair.errors, status: :unprocessable_entity }
        end
      end
    
    else
      respond_error_not_owner
    end
  end
  
  def destroy
    if current_user_is_bike_owner
      if @repair.destroy
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

  def set_repair
    @repair = Repair.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "Repair not found" }, status: 404    
  end
  
  def repair_params
    params.require(:repair).permit(:description, :note, :price, :date)
  end

end
