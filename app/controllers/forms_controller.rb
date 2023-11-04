class FormsController < ApplicationController
  def line_login
    @event_id = params[:event_id]
    render 'forms/line_login'
  end

  def show
    event_id = params[:event_id]

    # イベントが見つからない場合、最初のイベントを取得する。本当はだめだよ!!
    event = Event.find_by(id: event_id) || Event.first
    # TODO: LINE連携のパラメーターをUserのモデルへセットする
    @user = event.users.build(line_id: "line_id")
  end

  def create
    @user = User.new(user_params)
    # TODO: アイコンのURLをセットする
    @user.icon_id = Icon.first.id
    
    if @user.save
      redirect_to success_path
    else
      render 'forms/show'
    end
  end

  def create_success
    render 'forms/create_success'
  end

  private

  def user_params
    params.require(:user).permit(:name1, :name2, :profile, :from, :to, :line_id, :event_id, :line_id)
  end
end
