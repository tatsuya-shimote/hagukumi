class Api::V1::UsersController < ApiController
  before_action :require_login, only: [:show]
 
  # 拾えなかったExceptionが発生したら500 Internal server errorを応答する
  rescue_from Exception, with: :render_status_500

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  # def index
  #   employees = Employee.select(:id, :name, :department, :gender)
  #   render json: employees
  # end

  def show
    @user = User.find_by(id: params[:id])
    if @user == @current_user
      payload = @user
    else
      payload = {message: "メールアドレスまたはパスワードが違います。", judge: true}
    end
      render json: payload
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def calender
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end
    
end