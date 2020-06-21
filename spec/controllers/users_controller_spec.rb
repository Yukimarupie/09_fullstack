require 'rails_helper'

RSpec.describe UsersController, type: :controller do

#app/controllers/users_controller.rbのnewメソッドをテストするコード

  describe 'GET #new' do
    #コントローラーのnewアクションにgetのHTTメソッドでアクセスすることを擬似的に
    #行う。これによってgetのリクエスト結果がresponseという変数に格納される。
    before { get :new }

    #expectにresponseを渡し、have_http_statusのマッチャを使うことでstatusコードをテストできる
    #:okで200であることをテストするという意味。数字を直接入れてもok
    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end
    
    #レンダリングするtemplateをテストするコード。
    #マッチャにはrender_templateを使うことで、指定したtemplateがレンダリングされているかをテストできる
    #このマッチャはrails_contoroller_testingのGemで使えるようになっている
    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    #ビューに渡されるべき変数をテストしている。
    #user変数をテストしたいので:userとしている
    #マッチャにはbe_a_newを使いuserクラスの新しいオブジェクトがセットされていることをテストする
    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end
end

