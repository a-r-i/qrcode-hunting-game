class RemoveUrlToHistories < ActiveRecord::Migration[5.1]
  def change
    remove_column :histories, :url, :string
  end
end
