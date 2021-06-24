class Api::V1::UsersController < ApiController
  before_action :require_login, only: [:show, :update]

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
  
  def update
    if (@current_user && @current_user.update(user_edit_params))
      render json: {message: "プロフィールを変更しました"}
    else
      render json: {errors: "保存に失敗しました。もう一度入力してください。 "}, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
    
    def user_edit_params
      params.require(:user).permit(:name)
    end
    
end