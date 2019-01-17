require 'active_record'
require 'uri'
require 'json'
require 'net/http'
require 'clockwork'
include Clockwork

handler do |job|
  case job
    when "frequent.job"
      begin
        # DB接続設定
        ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
        # テーブルにアクセスするためのクラスを宣言
        class Qrcode < ActiveRecord::Base
        end

        qrcode = Qrcode.all

        uri = URI.parse('https://api.com/sum-bpm-a-minute')
        # uri = URI.parse('http://localhost:4567/sum-bpm-a-minute')
        json = Net::HTTP.get(uri)
        result = JSON.parse(json)
        count = result["sum-bpm-a-minute"]

        while count > 0 do
          i = rand(0..49)
          qrcode[i].coin = qrcode[i].coin + 1
          qrcode[i].save
          count = count - 1
        end

      ensure
        ActiveRecord::Base.connection.close
      end
  end
end

every(60.seconds, 'frequent.job')