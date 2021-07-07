require 'rails_helper'

# require_loginを使うためにmoduleを作ったinclude?
# そのmoduleにはcurrent_userを定義して使えるようにする?

# indexアクション
# indexアクションの前にrequire_loginが実行されているか
# current_userの情報を利用
# jsonを返しているか
# ステータスコードは正しいか


# createアクション
# user.newアクションが正しく実行されている
# user.saveがtrueの場合sessionにuser.idが格納されuserのjsonを返す
# falseならエラーを返す。
# ステータスコードは正しいか


# showアクション
# indexアクションの前にrequire_loginが実行されているか
# paramsに対するuserが存在するか
# そのuserがcurrent_userか
# hugs_pointが求められているか
# jsonを返しているか
