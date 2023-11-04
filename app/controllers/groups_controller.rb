class GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    client = OpenAI::Client.new(
      access_token: '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',
      request_timeout: 240
    );
    # client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN']);

    content = make_content;
    if content.empty?
      render json: '対象のユーザが存在しません'
      return
    end
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "user", content: content}]
      }
    );

    res = response.dig("choices", 0, "message", "content");
    render json: res;
  end

  private
  def make_content
    user_list = User.where(event: params[:event_id], group: nil);

    if user_list.empty?
      return []
    end

    user_bullet_point = user_list.map do |u|
      "・名前:#{u.name1} #{u.name2} プロフィール: #{u.profile} 空き時間: #{u.from} ~ #{u.to} ユーザーID: #{u.id}"
    end

    return "以下のユーザから共通点を見出して3人以上かつ4人以下のグループを作成してください。グループ分けをする際にどこのグループにも所属しない人が出ないようにしてください。#{user_bullet_point} 結果は以下のjson形式で返答してください
      返信は必ず以下のjson形式に則ってください。以下の形式のjson以外は絶対に回答に含めてはいけません。グループ分けの理由も含めてはいけません。
      {
        'group_name': 'サンプル',
        'members': [
          '一人目', '二人目'...
        ],
        'ユーザーID': [
          1,2,3...
        ]
      }
      各項目の説明は以下の通りです。
      'group_name':日本語でグループ名を考えてつけてください。共通点から考えなくても構いません。連番は使用しないでください。
      'members':チームに所属した人の名前を配列で表示してください。
      'ユーザーID': チームに所属した人のユーザーIDを配列で表示してください。
    ";
  end
end
