class BikesController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "oligofren", only: :destroy

  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  # GET /bikes
  def index
    @bikes = Bike.all
  end

  # GET /bikes/1
  def show
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
  end

  # GET /bikes/1/edit
  def edit
    # in function set_bike we find hash by command: @bike = Bike.find(params[:id])
  end


  # POST /bikes
  def create
    @bike = Bike.new(bike_params)
      if @bike.save
        redirect_to bikes_path
      else
        render 'new'
      end
  end


  # PATCH/PUT /bikes/1
  def update
    if @bike.update(bike_params)
      redirect_to bikes_path
    else
      render 'edit'
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @bike.destroy
    redirect_to bikes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bike
      @bike = Bike.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bike_params
      params.require(:bike).permit(:name, :user_name, :year, :color)
    end
end
