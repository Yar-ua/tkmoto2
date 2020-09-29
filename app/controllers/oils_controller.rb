class OilsController < ApplicationController
  before_action :set_bike
  before_action :set_oil, only: [ :edit, :update, :destroy ]

  def index
    @oils = @bike.oils.order(oil_change: :desc)
  end

  def show
  end

  def new
    @oil = Oil.new
  end

  def edit
  end

  def create
    @oil = @bike.oils.build(oil_params)

    respond_to do |format|
      if @oil.save
        format.html { 
          flash[:success] = 'Oil was successfully created.'
          redirect_to bike_oils_path(@bike)
        }
        format.json { render :show, status: :created, location: @oil }
      else
        format.html { 
          flash[:error] = 'Something wrong, try again'
          render :new 
        }
        format.json { render json: @oil.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @oil.update(oil_params)
        format.html { 
          flash[:success] = 'Oil was successfully updated.'
          redirect_to bike_oils_path(@bike) 
        }
        format.json { render :show, status: :ok, location: @oil }
      else
        format.html { 
          flash[:error] = 'Something going wrong, try again'
          render :edit
        }
        format.json { render json: @oil.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @oil.destroy
      flash[:success] = 'Oil was successfully destroyed.'
      redirect_to bike_oils_path(@bike)
    end
  end

  private
  
    def set_bike
      @bike = Bike.find_by_id(params[:bike_id])
    end

    def set_oil
      @oil = Oil.find_by_id(params[:id])
    end


    def oil_params
      params.require(:oil).permit(:oil_change)
    end
end
