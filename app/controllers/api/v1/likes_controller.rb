class Api::V1::Likes < ApiController
  before_action :require_login
  def create
    micropost = Micropost.find_by(id: params[:id])
    @current_user.like(micropost)
    render json: {message: "幸せをもらいました", like: true}
  end
  
  def destroy
    micropost = Micropost.find_by(id: params[:id])
    @current_user.unlike(micropost)
    render json: {message: "幸せが減りました...", like: false}
  end
end