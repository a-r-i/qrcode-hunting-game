class MiningController < ApplicationController

  def index
    p params[:id]
    if logged_in?
      p "ログイン済"
      p session[:user_id]
      p user = User.find(session[:user_id])
      p user.id
      qrcode = Qrcode.where(url: params[:id])
      result = History.where(qrcode: qrcode[0].id, user: user.id).count
      p "このユーザーがこのQRコードを何回採掘したか：#{result}"

      @histories = History.where(qrcode: qrcode[0].id).order("timestamp ASC")
      p "このQRコードを採掘した人数：#{@histories.count}"

      if result == 0
        p "未採掘"
        user.coin = user.coin + qrcode[0].coin
        user.save
        @message = "#{qrcode[0].coin}・を採掘した！　現在の残高は#{user.coin}です"
        qrcode[0].coin = 0
        qrcode[0].save
        history = History.new(timestamp: Time.now.to_i, qrcode: qrcode[0].id, user: user.id)
        history.save
      else
        p "採掘済"
        @message = "このQRコードは採掘済です。一つのQRコードにつき一人一回まで採掘できます。"
      end
    else
      p "未ログイン"
      redirect_to "/signup", alert: 'ログインしてください'
    end
  end
end
