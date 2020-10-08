class BikesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  # GET /bikes.json
  def index
    @bikes = Bike.all #.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.json { render json: @bikes }
    end
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
    respond_to do |format|
      format.html
      format.json { render json: @bike }
    end
  end
  
  # GET /bikes/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @bike }
    end
  end

  # GET /bikes/1/edit
  def edit
  end


  # POST /bikes.json
  def create
    @bike = current_user.bikes.build(bike_params)
    if @bike.save
      respond_to do |format|
        format.html
        format.json { render @bike, status: 200 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render @bike.errors, status: 422 }
      end
    end
  end


  # PATCH/PUT /bikes/1.json
  def update
    if current_user.id === @bike.user_id
      if @bike.update(bike_params)
        render json: { bike: @bike, status: 200 }
      else
        render json: { errors: @bike.errors, status: 422 }, status: 422
      end
    else
      render json: { errors: 'You have not credentials', status: 422 }, status: 422
    end
  end

  # DELETE /bikes/1.json
  def destroy
    if current_user.id === @bike.user_id
      @bike.destroy
      render json: { success: true, status: 200 }
    else
      render json: { errors: 'You have not credentials', status: 422 }, status: 422
    end
  end

  private

    def set_bike
      @bike = Bike.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "bike not found" }, status: :not_found
    end

    def bike_params
      params.require(:bike).permit(:name, :volume, :year, :color)
    end
end
