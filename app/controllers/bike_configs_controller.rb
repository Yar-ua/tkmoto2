class BikeConfigsController < ApplicationController
  before_action :set_bike
  
  def show
    if @bike.bike_config
      redirect_to  edit_bike_bike_configs_path(@bike)
    else
      render action: :new
    end
  end
  
  def new
    @bike_config = BikeConfig.new
  end
  
  def create
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
      format.json { render :show, status: :created, location: @bike_config }
      else
        format.html { render :new }
        format.json { render json: @bike_config.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @bike_config = @bike.bike_config
  end

  def update
    @bike_config = @bike.bike_config
    respond_to do |format|
      if @bike_config.update(config_params)
        format.html { 
          flash[:success] = 'Bike config was successfully updated'
          redirect_to bike_bike_configs_path(bike_id: @bike_config.bike_id)
        }
        format.json { render :show, status: :created, location: @bike_config}
      else
        format.html { render :edit }
        format.json { render json: @bike_config.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  private

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end
  
  def config_params
    params.require(:bike_config).permit(:oil_change)
  end
    
end
