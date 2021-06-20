class Api::V1::SessionsController < ApiController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      payload = {message: "ログインに成功しました。", user_id: user.id, judge: true}
    else
      payload = {message: "メールアドレスまたはパスワードが違います。", judge: false}
    end
    render json: payload
    
  end
  
  def destroy
    session[:user_id] = nil
    render json: {message: "使ってくれてありがとう。またきてね"}
  end
end