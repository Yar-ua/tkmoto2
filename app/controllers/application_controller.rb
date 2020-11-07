class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  protect_from_forgery unless: -> { request.format.json? }
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def current_user_is_bike_owner
    return true if current_user.id == @bike.user_id
  end
  
  def respond_error_not_owner
    respond_to do |format|
      format.html { 
        flash[:error] = 'You have not credentials'
        render :new 
      }
      format.json { render json: {errors: 'You have not credentials'}, status: 422 }
    end
  end
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
  end
        
end
