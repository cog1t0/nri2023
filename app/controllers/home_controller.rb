class HomeController < ApplicationController
  protect_from_forgery except: :webhook
  # before_action :validate_signature, only: [:webhook]

  def index
    render plain: 'Hello World!'
  end

  def webhook
    puts("===== webhook =====")
    body = request.body.read
    puts("===== #{body} =====")
    # events = line_client.parse_events_from(body)
    # puts("===== #{events} =====")
    # events.each do |event|
    #   @line_id = event['source']['userId']
    #   @user = User.find_or_create_by_line_id(@line_id)
    #   case event
    #   when Line::Bot::Event::Message
    #     case event.type
    #     when Line::Bot::Event::MessageType::Text
    #       message = 
    #         {
    #           type: 'text',
    #           text: events.inspect
    #         }    
    #       LineBot.reply_message(event['replyToken'], message)
    #     else          
    #     end
    #   end
    # end
  end

  def line_bot_send_push_message
    LineBot.push_message('LINEID', { type: 'text', text: 'Hello World!' })
  end

  def test
    render plain: "===== !!!!! #{ENV["LINE_CHANNEL_SECRET"]}"
  end

  private
  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless line_client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end
end
