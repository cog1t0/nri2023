class HomeController < ApplicationController
  protect_from_forgery except: :webhook
  before_action :validate_signature, only: [:webhook]

  def index
    puts "========== home#index =========="
    @event_id = params[:event_id]
    render 'forms/line_login'

    # render plain: 'Hello World!'
  end

  def webhook
    puts("===== webhook =====")
    body = request.body.read
    puts("===== #{body} =====")
    events = LineBot.parse_events_from(body)
    puts("===== #{events} =====")
    events.each do |event|
      @line_id = event['source']['userId']
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = 
            {
              type: 'text',
              text: event.inspect
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
    LineBot.push_message('Ufc7fa0885cb79fbd58e6c360de55c8ee', { type: 'text', text: 'Hello World!' })
  end

  def test
    render plain: "===== !!!!! #{ENV["LINE_CHANNEL_SECRET"]}"
  end

  private
  def validate_signature
    puts("===== validate_signature =====")
    body = request.body.read
    puts("===== body #{body} =====")
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    puts("===== signature #{signature} =====")
    if LineBot.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end
end
