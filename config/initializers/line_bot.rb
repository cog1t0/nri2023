require 'line/bot'

LineBot = Line::Bot::Client.new { |config|
  config.channel_secret = ENV["LINE_CHANNEL_SECRET"] || "e9d03632772716b6592130858b0f15de"
  config.channel_token = ENV["LINE_CHANNEL_TOKEN"] || "n9Yh2Hzr4M+YGew2XO+yFO4mAEGGXlU3dsww+rVkBeJe5NHwl4HGv790ZJxDLx4q91VaRwR3G+x6BHWiFfD3SV0snRhE9vehLVddNuXlBEE8snXu4beM8Y8J3EC2XOegyg7y6yyvWmKJSro5PmDLsgdB04t89/1O/w1cDnyilFU="
}