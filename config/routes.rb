Rails.application.routes.draw do
  get 'users/profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  post '/home/webhook', to: 'home#webhook'
  get '/home/test', to: 'home#test'
  get '/home/line_bot_send_push_message', to: 'home#line_bot_send_push_message'
end
