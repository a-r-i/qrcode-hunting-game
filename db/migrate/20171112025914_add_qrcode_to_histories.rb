class AddQrcodeToHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :qrcode, :integer
  end
end
