class UsersController < ApplicationController
  def new
    @user = User.new(flash[:user])
  end

=begin
このflash[:user]で、エラーに引っかかった場合もuser名が残ったままにできる。lec84で追加
=end


  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      redirect_to :back, flash: {
        user: user,
        error_messages: user.errors.full_messages
      }
    end
  end
=begin
ifの処理の前にpasswordとpassword_confirmationの値が等しいかどうかもチェックされる
saveが完了した場合は、session情報のuser_idというキーに登録したuserのidを保存してマイページにリダイレクトする。
このsession変数はアクセスしてきたuserのsession情報を扱うための特殊変数。session変数の任意のキーに値をセットすることで、ページをまたいで変数の値を保持できる
=end

  def me
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
