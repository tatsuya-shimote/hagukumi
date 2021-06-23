class ApiController < ActionController::API
  # include ActionController::Cookies
  before_action :check_xhr_header, only: [:cerate, :update]
  private

  def require_login
    @current_user = User.find_by(id: session[:user_id])
    return if @current_user
  end

  def check_xhr_header
    return if request.xhr?

    render json: { error: 'forbidden' }, status: :forbidden
  end
end