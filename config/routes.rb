Rails.application.routes.draw do
  # get 'profile', to "form#profile_get"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  post '/home/webhook', to: 'home#webhook'

  # QRコード読み取り後のLINEログインページ
  get '/login', to: "forms#login"
  get '/line_login', to: "forms#line_login"
  get 'line_login_api/callback', to: 'forms#callback'

  # フォーム表示、登録
  get 'profile', to: "forms#profile"
  post 'forms/create'
  get 'success', to: "forms#create_success"

  get '/home/test', to: 'home#test'
  get '/home/line_bot_send_push_message', to: 'home#line_bot_send_push_message'
  post '/groups/:event_id', to: 'groups#create'
end
