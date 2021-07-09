class Api::V1::MicropostsController < ApiController
  before_action :require_login
  
  def index
    #フォローしているユーザーのみポストを時系列で表示
  end
  
  def create
    user = @current_user
    micropost = user.microposts.build(microposts_params)
    if micropost.save
      render json: {message: "投稿しました"}
    else
      render json: {error: "投稿に失敗しました"}
    end
  end
  
  def delete
    micropost = current_user.microposts.find_by(id: params[:post_id])
    if micropost.nil?
      render json: {message: "すでに削除されています"}
    else
      micropost.destroy
      render json: {message: "削除しました"}
    end
  end
  
  private
  
  def microposts_params
    params.permit(:content)
  end
  
  
end