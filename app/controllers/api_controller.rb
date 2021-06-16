class ApiController < ActionController::API
  include ActionController::Cookies
 
  private

  def require_login
    @current_user = User.find_by(id: session[:user_id])
    return if @current_user
  end
end