class UserController < ApplicationController

  def signup
    if logged_in?
      p "ログイン済"
      redirect_to "/", alert: 'ログイン済'
    end
  end

  def infomation
    @qrcode_coin_sum = "#{Qrcode.all.sum(:coin)}・"

    if logged_in?
      p "ログイン済"
      p session[:user_id]
      p user = User.find(session[:user_id])
      p user.id
      @balance = "#{user.coin}・"
    end
  end

  def payment
    if logged_in?
      p "ログイン済"
      p session[:user_id]
      p user = User.find(session[:user_id])
      p user.id

      @username = user.name

      if request.post?
        p params
        if 300 > user.coin
          redirect_to "/payment/completion/fail", alert: '支払い失敗'
        else
          user.coin = user.coin - 300
          user.save
          redirect_to "/payment/completion/success", alert: '支払い完了'
        end
      end
      @balance = "#{user.coin}・"
    else
      p "未ログイン"
      redirect_to "/signup", alert: 'ログインしてください'
    end
  end

  def payment_completion
    p params[:result]
    if params[:result] != nil
      case params[:result]
        when "success" then
          @message = "300・を支払いしました。#{Time.now}"
          @message_type = 'success'
        when "fail" then
          @message = "残高が足りません"
          @message_type = 'danger'
        else
          redirect_to "/payment", alert: ''
      end
    end
  end
end
