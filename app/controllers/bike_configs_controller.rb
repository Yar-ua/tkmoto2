class BikeConfigsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_bike
  
  def new
    @bike_config = BikeConfig.new
  end
  
  def create
    if current_user_is_bike_owner
    
      # this is unpredictible builder for 'has_one' association, like:
      # user.build_profile  # this will work
      # user.profile.build  # this will throw error
      # find it in rails documentation or according this Stackoverwlow link 
      # https://stackoverflow.com/questions/2472982/rails-using-build-with-a-has-one-association-in-rails
      @bike_config = @bike.build_bike_config(config_params)
      respond_to do |format|
        if @bike_config.save
          format.html { 
            flash[:success] = 'Bike configurations was successfully created'
            redirect_to bike_bike_configs_path(@bike_config)
          }
        format.json { render @bike_config, status: 200 }
        else
          format.html { 
            flash[:error] = 'Wrong arguments, try again'
            render :new
          }
          format.json { render json: @bike_config.errors, status: 422 }
        end
      end
      
    else
      respond_error_not_owner
    end
  end

  def show
    @bike_config = @bike.bike_config
  end

  def update
    if current_user_is_bike_owner
      
      @bike_config = @bike.bike_config
      respond_to do |format|
        if @bike_config.update(config_params)
          format.html { 
            flash[:success] = 'Bike config was successfully updated'
            redirect_to bike_bike_configs_path(bike_id: @bike_config.bike_id)
          }
          format.json { render @bike_config, status: 200}
        else
          format.html { 
            flash[:error] = 'Wrong arguments, try again'
            render :edit }
          format.json { render json: @bike_config.errors, status: 422 }
        end
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
  
  def config_params
    params.require(:bike_config).permit(:oil_change)
  end
    
end
