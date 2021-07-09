class Api::V1::HugsController < ApiController
  before_action :require_login
  
  def index
    hugs = @current_user.hugs
    render json: hugs
  end  
  
  def create
    hug = @current_user.hugs.build(hug_params)
    if hug.save
      render json: hug
    else
      render json: { errors: hug.errors.keys.map { |key| [key, hug.errors.full_messages_for(key)]}.to_h }, status: :unprocessable_entity
    end
  end
  
  def update
    hug = @current_user.hugs.find_by(id: params[:id])
    if (hug && hug.update(hug_params))
      render json: hug
    else
      render json: {errors: "保存に失敗しました。もう一度入力してください。 "}, status: :unprocessable_entity
    end
  end
  
  def destroy
    hug = @current_user.hugs.find_by(id: params[:id])
    hug.destroy!
  end
  
  private
  
  def hug_params
    params.permit(:count, :user_id, :year, :month, :date)
  end
  
end