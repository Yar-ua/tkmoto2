class BikesController < ApplicationController

  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  # GET /bikes
  # GET /bikes.json
  def index
    @bikes = Bike.all.paginate(page: params[:page], per_page: 10)
    # render json: @bikes
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
  end
  
  # GET /bikes/1
  # GET /bikes/1.json
  def show
  end

  # GET /bikes/1/edit
  def edit
  end


  # POST /bikes
  # POST /bikes.json
  def create
    @bike = Bike.new(bike_params)
    respond_to do |format|
      if @bike.save
        format.html { 
          flash[:success] = 'Bike was successfully created'
          redirect_to bikes_path 
        }
        format.json { render :show, status: :created, location: @bike }
      else
        format.html { render :new }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /bikes/1
  # PATCH/PUT /bikes/1.json
  def update
    respond_to do |format|
      if @bike.update(bike_params)
        format.html { 
          flash[:success] = 'Bike was successfully updated'
          redirect_to bikes_path 
        }
        format.json { render :show, status: :ok, location: @bike }
      else
        format.html { render 'edit' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @bike.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = 'Bike was successfully deleted'
        redirect_to bikes_url
        }
      format.json { head :no_content }
    end
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
    end

    def bike_params
      params.require(:bike).permit(:name, :volume, :year, :color)
    end
end
