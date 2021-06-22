class Api::V1::SessionsController < ApiController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {message: "ログインに成功しました。", user_id: user.id}
    else
      render json: {errors: "メールアドレスまたはパスワードが違います。"}, status: :unprocessable_entity
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    render json: {message: "使ってくれてありがとう。またきてね"}
  end
end