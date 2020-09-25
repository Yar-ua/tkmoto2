class RepairsController < ApplicationController
  before_action :set_bike

  def index
    render :index
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

  def edit
  end




  private

  def set_bike
    @bike = Bike.find_by_id(params[:bike_id])
  end

  def repair_params
    params.require(:repair).permit(:type, :note, :price, :date)
  end


end
