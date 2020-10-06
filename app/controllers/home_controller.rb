class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:about]
  
  def about
  end
  
  def secure
    render json: "Secure area, only for register users. If you watch it - you signed in"
  end
end
