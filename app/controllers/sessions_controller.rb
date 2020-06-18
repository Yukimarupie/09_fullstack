class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      render 'home/index'
    end
  end
#最初にparams:session:nameから該当userを検索して取得。find_byは引数で指定した条件にマッチするものを一つ取得するメソッド。
#ifの所。userがいない場合はelseに入る。user.authenticateが、find_byで取得したuser名とpasswordがマッチしているか確認する場所。authenticateメソッドもuserモデルにhas_secureを追記したことで自動的に追加されたメソッド。
#if=trueなら、session情報にuser_idを保存したのち、マイページに飛ばす。

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
