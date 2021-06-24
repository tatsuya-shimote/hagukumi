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
    user = User.find_by(id: params[:id])
    if user && user == @current_user
      hugs_point = Hug.where("user_id = :user_id",{user_id: params[:id]}).sum(:count)
      render json: {name: user.name, hug_count_sum: hugs_point}
    else
      render json: {message: "メールアドレスまたはパスワードが違います。"}, status: :unprocessable_entity
    end
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