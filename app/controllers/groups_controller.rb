class GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # res_str = call_chatgpt_api;
    # if res_str.empty?
    #   render json: '対象のユーザーが存在しません。' and return;
    # end
    # render json: res_str;
    
    res_str = '[ { "team_name": "赤い羽根", "members": ["名前0", "名前1", "名前2", "名前3"], "user_ids": [1,2,3,4] }, { "team_name": "緑の風", "members": ["名前4", "名前5", "名前6", "名前7"], "user_ids": [5,6,7,8] }, { "team_name": "青い海", "members": ["名前8", "名前9", "名前10", "名前11"], "user_ids": [9,10,11,12] }, { "team_name": "黄色い大地", "members": ["名前12", "名前13", "名前14"], "user_ids": [13,14,15] }, { "team_name": "紫の雲", "members": ["名前15", "名前16", "名前17"], "user_ids": [16,17,18] }, { "team_name": "白い光", "members": ["名前18", "名前19", "名前20"], "user_ids": [19,20,21] }, { "team_name": "黒い夜", "members": ["名前21", "名前22", "名前23"], "user_ids": [22,23,24] }, { "team_name": "虹色の未来", "members": ["名前24", "名前25", "名前26"], "user_ids": [25,26,27] }, { "team_name": "多色の夢", "members": ["名前27", "名前28", "名前29"], "user_ids": [28,29,30] } ]'
    res_json = JSON.parse(res_str);

    groups = res_json.map do |r|
      group = Group.create!(team_name: r['team_name']);
      make_suggest(group.id);
      r['user_ids'].each do |user_id|
        user = User.find(user_id);
        user.update_attribute(:group_id, group.id);
        # user.line_idを使用して、Push通知
        push_notify(user.line_id, group.id);
      end
    end
  end

  private
  def call_chatgpt_api
    client = OpenAI::Client.new(
      access_token: ENV['OPENAI_ACCESS_TOKEN'],
      request_timeout: 240
    );

    content = make_content;
    if content.empty?
      return [];
    end
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{role: "user", content: content}]
      }
    );

    return response.dig("choices", 0, "message", "content");
  end

  def line_client
    @line_client ||= Line::Bot::Client.new {|config| 
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end

  def push_notify(user_line_id, group_id)
    stores = Group.find(group_id).suggests.map do |suggest|
      suggest.store.name;
    end

    message={
      type: 'text',
      text: "飲み友達が見つかりました。以下をご確認下さい。#{stores.join('/')}"
    }
    response = line_client.push_message(user_line_id, message)
  end

  def make_suggest(team_id)
    stores = Store.limit(3);
    stores.each do |store|
      Suggest.create!(
        'group_id': team_id,
        'store_id': store.id
      )
    end
  end

  def make_content
    user_list = User.where(event_id: params[:event_id], group_id: nil);

    if user_list.empty?
      return []
    end

    user_bullet_point = user_list.map do |u|
      "名前:#{u.name1} #{u.name2} プロフィール: #{u.profile} 空き時間: #{u.from} ~ #{u.to} ユーザーID: #{u.id},"
    end

    return "以下のユーザを3人以上かつ4人以下のチームに分けてください。チーム分けをする際にどこのチームにも所属しない人が絶対に出ないようにしてください。ユーザーリスト:#{user_bullet_point}
      返信は必ず以下のjson形式に従ってください。以下のjson形式以外のものは絶対に回答に含めてはいけません。
      [
        {
          \"team_name\": \"サンプル\",
          \"members\": [
            \"一人目\", \"二人目\"...
          ],
          \"user_ids\": [
            1,2,3...
          ]
        },...
      ]
      各項目の説明は以下の通りです。
      \"team_name\":日本語でグループ名を考えてつけてください。共通点から考えなくても構いません。連番は使用しないでください。
      \"members\":チームに所属した人の名前を配列で表示してください。
      \"user_ids\": チームに所属した人のユーザーIDを配列で表示してください。
    ";
  end
end
