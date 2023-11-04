class HomeController < ApplicationController
  def index
    render plain: 'Hello World!'
  end

  def webhook
    return :success
  end

  def line_bot_send_push_message
    LineBot.push_message('LINEID', { type: 'text', text: 'Hello World!' })
  end
end
