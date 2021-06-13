class Api::V1::SessionsController < ApiController
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: @user
    end
  end
end