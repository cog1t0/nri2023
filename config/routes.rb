Rails.application.routes.draw do
  # get 'profile', to "form#profile_get"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  post '/home/webhook', to: 'home#webhook'

  # QRコード読み取り後のLINEログインページ
  get '/line_login', to: "forms#line_login"

  # フォーム表示、登録
  get 'forms/show'
  post 'forms/create'
  get 'success', to: "forms#create_success"

  get '/home/test', to: 'home#test'
  get '/home/line_bot_send_push_message', to: 'home#line_bot_send_push_message'
end
