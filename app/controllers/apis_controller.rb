class ApisController < ApplicationController
  def index
    qrcodes = Qrcode.all
    qrcode_coin_sum = 0

    qrcodes.each{ |qrcode|
      qrcode_coin_sum = qrcode_coin_sum + qrcode.coin
    }

    result = {'qrcodecoinsum' => qrcode_coin_sum}

    render :json => result
  end
end
