class OilsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_bike
  before_action :set_oil, only: [:show, :edit, :update, :destroy ]

  def index
    @oils = @bike.oils.order(oil_change: :desc)
  end

  def show
  end

  def new
    @oil = Oil.new
  end

  def create
    if current_user_is_bike_owner
      
      @oil = @bike.oils.build(oil_params)
      respond_to do |format|
        if @oil.save
          format.html { 
            flash[:success] = 'Oil was successfully created.'
            redirect_to bike_oils_path(@bike)
          }
          format.json { render @oil, status: 200 }
        else
          format.html { 
            flash[:error] = 'Something wrong, try again'
            render :new 
          }
          format.json { render json: @oil.errors, status: 422 }
        end
      end
      
    else
      respond_error_not_owner
    end
  end

  def update
    if current_user_is_bike_owner
      
      respond_to do |format|
        if @oil.update(oil_params)
          format.html { 
            flash[:success] = 'Oil was successfully updated.'
            redirect_to bike_oils_path(@bike) 
          }
          format.json { render @oil, status: 200 }
        else
          format.html { 
            flash[:error] = 'Something going wrong, try again'
            render :edit
          }
          format.json { render json: @oil.errors, status: 422 }
        end
      end
      
    else
      respond_error_not_owner
    end
  end

  def destroy
    if current_user_is_bike_owner
      if @oil.destroy
        render json: {success: true, status: 200}
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

  def set_oil
    @oil = Oil.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: "Oil not found" }, status: 404    
  end


  def oil_params
    params.require(:oil).permit(:oil_change)
  end
end
