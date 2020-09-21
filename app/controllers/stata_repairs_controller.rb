class StataRepairsController < ApplicationController
  before_action :set_view_stata_repair


  def new
  	@bike = Bike.find(params[:bike_id])
  	@stata_repair_err = StataRepair.new
  end

  def edit
  end




  private

  def set_view_stata_repair
  	@view_stata_repair = StataRepair.where("bike_id = ?", params[:bike_id]).order(id: :desc)
  end



end
