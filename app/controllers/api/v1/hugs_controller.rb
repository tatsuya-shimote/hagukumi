class Api::V1::HugsController < ApiController
  before_action :require_login
  
  def index
    @hugs = @current_user.hugs
    render json: @hugs
  end  
  
  def create
    @hug = @current_user.hugs.build(hug_params)
    if @hug.save
      render json: @hug
    else
      render json: {errors: "登録に失敗しました。"}
    end
  end
  
  # def edit
  # end
  
  private
  
  def hug_params
    params.permit(:count, :user_id, :time)
  end
  
end