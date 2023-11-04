class HomeController < ApplicationController
  protect_from_forgery except: :webhook
  # 一旦、削除
  # before_action :validate_signature, only: [:webhook]

  def index
    @event_id = params[:event_id]
    render 'forms/line_login'

    # render plain: 'Hello World!'
  end

  def webhook
    body = request.body.read
    events = line_client.parse_events_from(body)
    events.each do |event|
      @line_id = event['source']['userId']
      @user = User.find_or_create_by_line_id(@line_id)
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = 
            {
              type: 'text',
              text: events.inspect
            }    
          LineBot.reply_message(event['replyToken'], message)
        else          
        end
      end
    end
    
  end

  def login

    # CSRF対策用の固有な英数字の文字列
    # ログインセッションごとにWebアプリでランダムに生成する
    session[:state] = SecureRandom.urlsafe_base64

    # ユーザーに認証と認可を要求する
    # https://developers.line.biz/ja/docs/line-login/integrate-line-login/#making-an-authorization-request

    base_authorization_url = 'https://access.line.me/oauth2/v2.1/authorize'
    response_type = 'code'
    client_id = 'LINEログインチャネルのチャネルID' #本番環境では環境変数などに保管する
    redirect_uri = CGI.escape(line_login_api_callback_url)
    state = session[:state]
    scope = 'profile%20openid' #ユーザーに付与を依頼する権限

    authorization_url = "#{base_authorization_url}?response_type=#{response_type}&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"

    redirect_to authorization_url, allow_other_host: true
  end


  def line_bot_send_push_message
    LineBot.push_message('LINEID', { type: 'text', text: 'Hello World!' })
  end

  private
  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    if LineBot.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end
end
