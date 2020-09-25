class RepairsController < ApplicationController
  before_action :set_bike
  before_action :set_repair, only: [ :edit, :update, :destroy ]

  def index
    @repairs = @bike.repairs.order(date: :desc)
  end

  def new
    @repair = Repair.new
  end
  
  def create
    @repair = @bike.repairs.build(repair_params)
    respond_to do |format|
      if @repair.save
        format.html { 
          flash[:success] = 'Repair was successfully created'
          redirect_to bike_repairs_path(@bike)
        }
        format.json { render :show, status: :created, location: @repair}
      else
        format.html { render :new }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @repair.update(repair_params)
        format.html { 
          flash[:success] = 'Repair was successfully updated'
          redirect_to bike_repairs_path(bike_id: @repair.bike_id)
        }
        format.json { render :show, status: :created, location: @repair}
      else
        format.html { render :edit }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if @repair.destroy
        format.html { 
          flash[:success] = 'Repair was successfully deleted'
          redirect_to bike_repairs_path(bike_id: @repair.bike_id)
          }
        format.json { head :no_content }
      end
    end
  end


  private

  def set_bike
    @bike = Bike.find_by_id(params[:bike_id])
  end

  def set_repair
    @repair = Repair.find_by_id(params[:id])
  end
  
  def repair_params
    params.require(:repair).permit(:description, :note, :price, :date)
  end

end
