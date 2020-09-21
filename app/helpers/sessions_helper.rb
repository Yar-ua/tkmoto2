module SessionsHelper

  def sign_in(user)
  	remember_token = User.new_remember_token
  	cookies.permanent[:remember_token] = remember_token #установка истечения remember_token 
														# через 20 лет
# аналогично cookies[:remember_token] = { value: remember_token, expires: 20.years.from_now.utc }
  	user.update_attribute(:remember_token, User.encrypt(remember_token))
  	self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)   # аналогично self.current_user = ...
  	@current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end


  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end


  def store_location
    # поместить запрашиваемый url в переменную session под ключом :return_to
    # но только для get запроса (if request.get?)
    session[:return_to] = request.url if request.get?
  end


end