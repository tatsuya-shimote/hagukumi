class Api::V1::RelationshipsController < ApiController
  before_action :require_login
  
  def create
    user = User.find(params[:followed_id])
    @current_user.follow(user)
    render json: {message: "フォローしました", unfollow: false}
  end

  def destroy
    user = User.find(params[:id])
    @current_user.unfollow(user)
    render json: {message: "フォローを解除しました", unfollow: true}
  end
  
end