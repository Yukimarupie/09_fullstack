class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  private

  def current_user
    return unless session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
  end

#lecture86 sessionにuser_idの情報がなければreturnする。これはログインしていないことを意味する。
#もしuser_idが存在しfind_byで該当userがいれば@current_userに格納され、このuserが現在ログイン中のuserであるという判断ができる。
  
end
