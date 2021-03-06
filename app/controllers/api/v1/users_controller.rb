class Api::V1::UsersController < ApiController
  before_action :require_login, only: [:index, :show, :update, :profile, :following, :follower, :user_microposts]

  def index
    users = User.select(:id, :name, :image)
    user = @current_user
    render json: {users: users, current_user_id: user.id}
  end

  def show
    user = User.find_by(id: params[:id])
    if user && user == @current_user
      hugs_point = Hug.where("user_id = :user_id",{user_id: params[:id]}).sum(:count)
      render json: {name: user.name, hug_count_sum: hugs_point, image: user.image, id: user.id}
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
      render json: {errors: @current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end
  
  def profile
    user = User.find(params[:id])
    current_user = @current_user
    hugs_point = Hug.where("user_id = :user_id",{user_id: params[:id]}).sum(:count)
    if current_user.following?(user)
      render json: {id: user.id, name: user.name, image: user.image, hug_count_sum: hugs_point, current_user_id: current_user.id, unfollow: false}
    else
      render json: {id: user.id, name: user.name, image: user.image, hug_count_sum: hugs_point, current_user_id: current_user.id, unfollow: true}
    end
  end
  
  def following
    user = User.find(params[:id])
    followed = user.followings
    render json: followed
  end
  
  def follower
    user = User.find(params[:id])
    follower = user.follower
    render json: follower
  end
  
  def user_likes
    likes = @current_user.likes_post
    render json: {likes: likes}
  end
  
  def user_microposts
    user = User.find(params[:id])
    microposts = user.microposts
    if microposts.empty?
      render json: {message: "投稿がありません"}
    else
      render json: {userposts: microposts}
    end
  end
  
  
  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
    
    def user_edit_params
      params.permit(:name, :image)
    end
    
end