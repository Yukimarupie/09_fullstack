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


#===========================================================
#paramsで正常値と異常値値が渡ってきた場合のテスト
#===========================================================
  describe 'POST #create' do
    
    #describe 'POST #create' doの次のbefore doについて
    #redirect_to :back を実行した場合、userからのリクエストに含まれるHTTPリファラという
    #HTTPヘッダーの情報を見て、どこにredirectするのかを決めている。
    #リファラとは: 一つ前にどこのページを開いていたかという情報。テストの場合にはその情報はない。
    #リファラがない状態で、redirect_to :backを行うとエラーになる。
    #なので明示的にリファラを設定する必要がある
    
    before do
      @referer = 'http://localhost'
      @request.env['HTTP_REFERER'] = @referer
    end

    #==============================================
    #正常値用
    #==============================================

    context '正しいユーザー情報が渡って来た場合' do
      #正しいユーザー情報はletでparamsという名前で参照できるようにしている。
      #そのブロック内でパラメーターを定義している。
      #contextの通り、paramsの内容は全て正しいユーザー情報としている
      let(:params) do
        { user: {
            name: 'user',
            password: 'password',
            password_confirmation: 'password',
          }
        }
      end

      #一つ目のテストはユーザーが一人増えたことをテストしている
      #マッチャにはchangeとbyを組み合わせて使用することで、
      #Userモデルのカウントの結果がexpectの処理の前後で比較して一つ増えていることをテストしている
      #このマッチャを使用する婆いには、expectにはテスト対象の処理はブロックで指定する必要がある
      #changeマッチャはそのブロックの実行前後で対象の値の変化をテストするもの。
      #今回の場合はPOSTでcreateアクションを実行しているので、その前後でUser数の変化を検証している
      it 'ユーザーが一人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end
    

      #User作成が成功した場合に、マイページにリダイレクトされるかをテストする。
      #POSTでcreateアクションを実行した結果のレスポンスをexpectに渡して、
      #redirext_toのマッチャでmypage_pathにリダイレクトされることをテストする。
      it 'マイページにリダイレクトされること' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end      

  
    #==============================================
    #異常値用テストコード
    #==============================================
    context 'パラメーターに正しいユーザー名、確認パスワードが含まれていない場合' do
      before do
        post(:create, params: {
          user: {
            name: 'ユーザー1',
            password: 'password',
            password_confirmation: 'invalid_password'
          }
        }7/)
      end

      it 'リファラーにリダイレクトされること' do
        expect(response).to redirect_to(@referer)
      end
      it 'ユーザー名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード（確認)とパスワードの入力が一致しません'
      end
    end
  
  end
end
