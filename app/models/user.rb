class User < ApplicationRecord
  def self.find_or_create_from_auth(auth)
    uid = auth[:uid]
    display_name = auth[:extra][:raw_info][:name]

    self.find_or_create_by(uid: uid) do |user|
      user.name = display_name
      user.coin = 0
    end
  end
end
