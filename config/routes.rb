Rails.application.routes.draw do
  get 'mypage' , to: 'users#me'
  #/mypageのページにアクセスがきた場合は、userコントローラのmeアクションが呼ばれる
  
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #loginでは、セッションの作成を意味するのでpost, logoutはセッションの削除を意味するので、delete  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  resources :users, only: %i[new create]

  resources :boards
  resources :comments, only: %i[create destroy]

end

