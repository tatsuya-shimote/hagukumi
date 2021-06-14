class Api::V1::SessionsController < ApiController
 def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      payload = {message: "ログインに成功しました。", user_id: user.id, judge: true}
    else
      payload = {message: "メールアドレスまたはパスワードが違います。", judge: false}
    end
    render json: payload
  end
end