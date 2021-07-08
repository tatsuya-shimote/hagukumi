# Hugクミ
1日のハグの回数を記録し，ハグの習慣化を目指すアプリです。ハグの回数に応じて幸福度がポイントとして加算されていきます。  
(レスポンシブ対応，SPA化しています。)  
こちらがアプリのURLです。https://hagukumi.herokuapp.com/

# 作成した目的
[世界幸福度報告書](https://worldhappiness.report/)2021年版によると日本の幸福度ランキングは５６位。上位TOP１０のうち9カ国は欧州の国々。  
日本と欧州の違いは何か。それは**ハグの文化があるかどうかだ！!**  
そこでハグを習慣化すればより幸福度を上げることができるのではないかと考え，このアプリを作成しました。  
（この調査における幸福度は、自分の幸福度が0から10のどの段階にあるかを答える世論調査によって得られた数値の平均値
であるため、あくまで主観的な値です。ですのでこのランキングから日本人は幸せではない，ということではありません。）

# 使い方
新規登録またはログインに成功するとこのユーザー画面に遷移します。 
<img width="1436" alt="スクリーンショット 2021-07-07 15 59 28" src="https://user-images.githubusercontent.com/82424928/124869382-16ab2680-dffc-11eb-95ed-cb7d657951e3.png">
ここで幸福度が何ポイント貯まっているかを確認することができます。
また今日のハグの回数を記録することができます。  
今日のハグを記録ボタンを押して月、日、ハグの回数を入力することがでポイントが加算されます。
<img width="1436" alt="スクリーンショット 2021-07-07 15 59 38" src="https://user-images.githubusercontent.com/82424928/124869436-2f1b4100-dffc-11eb-964c-da80c7e5c5bd.png">
<img width="1434" alt="スクリーンショット 2021-07-07 15 59 54" src="https://user-images.githubusercontent.com/82424928/124869525-4bb77900-dffc-11eb-9f64-4e82e508d31a.png">
記録したら右上のメニューバーからカレンダーを開くと自動で記録されています。  
<img width="1436" alt="スクリーンショット 2021-07-07 16 02 26" src="https://user-images.githubusercontent.com/82424928/124869654-76a1cd00-dffc-11eb-9b91-1e1d9d0a0406.png">
<img width="1432" alt="スクリーンショット 2021-07-07 16 00 04" src="https://user-images.githubusercontent.com/82424928/124869692-8ae5ca00-dffc-11eb-9eee-b018c4f0cd2b.png">
カレンダーから記録の修正・削除ができます。
<img width="1434" alt="スクリーンショット 2021-07-07 16 00 10" src="https://user-images.githubusercontent.com/82424928/124869776-a7820200-dffc-11eb-9307-f54893d876e3.png">
ポイントが貯まると表示されるコメントが変わります。
<img width="1434" alt="スクリーンショット 2021-07-07 16 04 17" src="https://user-images.githubusercontent.com/82424928/124869835-bf598600-dffc-11eb-9771-cc9c336ff013.png">

# 使用技術
- HTML/CSS
- Ruby 2.6.7
- Ruby on Rails 6.0.3.7
- JavaScript
- Vue.js 2.6.14
- MySQL 5.7
- Puma
- AWS
    - S3
- Heroku

# 機能一覧
ユーザー登録/ログイン機能  
ハグのCRUD 
プロフィール画像設定機能(S3)  
カレンダー機能(Vuetify)  
ユーザーフォロー機能  
ユーザー検索機能

# 追加したい機能
幸福度ポイントお裾分け機能  
通知機能  
投稿機能  
いいね機能  
ランキング機能  

